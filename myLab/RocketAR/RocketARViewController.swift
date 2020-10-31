////
////  RocketViewController.swift
////  WWDC19
////
////  Created by Aaron Cheung 430 on 16/3/2019.
////  Copyright © 2019 Aaron Cheung 430. All rights reserved.
////
import UIKit
import ARKit
import SceneKit
import AVFoundation

protocol RocketViewControllerProtocol: class {
    var resultText: String! { get set }
}

public class RocketARViewController: UIViewController, ARSCNViewDelegate, ARSessionDelegate {
    // MARK: - Properties
    var resultText: String!
    
    public var sceneView: ARSCNView!
        
    public var planes = [OverlayPlane]()
    
    private lazy var startLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25.0, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nextBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "next"), for: .normal)
        btn.addTarget(self, action: #selector(nextBtnTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private lazy var resultLabel: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        lbl.layer.masksToBounds = true
        lbl.layer.cornerRadius = 4
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 16)
        lbl.textColor = .white
        lbl.alpha = 0
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private lazy var congratsLabel: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        lbl.layer.masksToBounds = true
        lbl.layer.cornerRadius = 4
        lbl.font = UIFont(name: "Arial Rounded MT Bold", size: 16)
        lbl.textColor = .white
        lbl.alpha = 0
        lbl.numberOfLines = 0
        lbl.text = "Congratulations! \nYou have finished the momentum AR lesson. Good luck with your further exploration!"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private var BackgroundView: UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    private var rocket :Rocket!
    
    var player: AVAudioPlayer?
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        
        sceneView = ARSCNView()
        sceneView.delegate = self
        
        let scene = SCNScene()
        sceneView.scene = scene
        
        sceneView.session.delegate = self
//        sceneView.debugOptions = [ ARSCNDebugOptions.showFeaturePoints ]
        
        self.view = sceneView
        
        registerGestureRecognizers()
        
        self.BackgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.BackgroundView)
        self.view.addSubview(self.startLabel)
        
        let startLabelleftMarginConstraint = NSLayoutConstraint(item: self.startLabel, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0)
        let startLabelrightMarginConstraint = NSLayoutConstraint(item: self.startLabel, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0)
        let startLabelcenterXConstraint = NSLayoutConstraint(item: self.startLabel, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let startLabelcenterYConstraint = NSLayoutConstraint(item: self.startLabel, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        let startLabelheightConstraint = NSLayoutConstraint(item: self.startLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0, constant: 200)
        self.view.addConstraints([startLabelleftMarginConstraint, startLabelrightMarginConstraint, startLabelcenterXConstraint, startLabelcenterYConstraint, startLabelheightConstraint])
        
        let BackgroundViewleftMarginConstraint = NSLayoutConstraint(item: self.BackgroundView, attribute: .left, relatedBy: .equal, toItem: self.startLabel, attribute: .left, multiplier: 1, constant: 0)
        let BackgroundViewrightMarginConstraint = NSLayoutConstraint(item: self.BackgroundView, attribute: .right, relatedBy: .equal, toItem: self.startLabel, attribute: .right, multiplier: 1, constant: 0)
        let BackgroundViewtopMarginConstraint = NSLayoutConstraint(item: self.BackgroundView, attribute: .top, relatedBy: .equal, toItem: self.startLabel, attribute: .top, multiplier: 1, constant: 0)
        let BackgroundViewbottomMarginConstraint = NSLayoutConstraint(item: self.BackgroundView, attribute: .bottom, relatedBy: .equal, toItem: self.startLabel, attribute: .bottom, multiplier: 1, constant: 0)
        self.view.addConstraints([BackgroundViewleftMarginConstraint, BackgroundViewrightMarginConstraint, BackgroundViewtopMarginConstraint, BackgroundViewbottomMarginConstraint])
        setupNextBtn()
        setupResultLabel()
        setupCongratsLabel()
        setupBackBtn()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100)) { [unowned self] in
            self.startLabel.text = "Move around to find a plane"
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        sceneView.session.run(configuration)
        resultLabel.text = resultText
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        sceneView.session.pause()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateLabel(resultLabel)
    }
    
    private func setupNextBtn() {
        view.addSubview(nextBtn)
        NSLayoutConstraint.activate([
            nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nextBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            nextBtn.widthAnchor.constraint(equalToConstant: 40),
            nextBtn.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupResultLabel() {
        view.addSubview(resultLabel)
        NSLayoutConstraint.activate([
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            resultLabel.bottomAnchor.constraint(equalTo: nextBtn.topAnchor, constant: -10)
        ])
    }
    
    private func setupCongratsLabel() {
        view.addSubview(congratsLabel)
        NSLayoutConstraint.activate([
            congratsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            congratsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            congratsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
    
    private func setupBackBtn() {
        view.addSubview(backBtn)
        NSLayoutConstraint.activate([
            backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            backBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backBtn.widthAnchor.constraint(equalToConstant: 30),
            backBtn.heightAnchor.constraint(equalTo: backBtn.widthAnchor)
        ])
    }
    
    //MARK: - Layout
    private func registerGestureRecognizers() {

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapped))
        sceneView.addGestureRecognizer(tapGestureRecognizer)

        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        tapGestureRecognizer.require(toFail: doubleTapGestureRecognizer)
        sceneView.addGestureRecognizer(doubleTapGestureRecognizer)
    }

    // MARK: - Actions
    @objc private func tapped(gesture: UITapGestureRecognizer) {
        
        self.startLabel.isHidden = false
        self.BackgroundView.isHidden = false
        
        self.startLabel.text = "Tap twice to launch!"
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.startLabel.isHidden = true
            self.BackgroundView.isHidden = true
        }
        
        let touchPosition = gesture.location(in: sceneView)

        let hitTestResults = sceneView.hitTest(touchPosition, types: .existingPlane)

        guard let hitTest = hitTestResults.first else {
            return
        }

        addRocket(hitTest)
    }
    
    public func addRocket(_ hitTest: ARHitTestResult) {

        let rocketScene = SCNScene(named: "art.scnassets/rocket.scn")

        let rocket = Rocket(scene: rocketScene!)
        rocket.name = "Rocket"
        rocket.position = SCNVector3(hitTest.worldTransform.columns.3.x, hitTest.worldTransform.columns.3.y, hitTest.worldTransform.columns.3.z)

        sceneView.scene.rootNode.addChildNode(rocket)
    }
    
    public func nodeForScene(sceneName :String,nodeName :String) -> SCNNode? {
        
        let scene = SCNScene(named: sceneName)!
        return scene.rootNode.childNode(withName: nodeName,recursively: true)
        
    }
    
    @objc private func doubleTapped(recognizer: UITapGestureRecognizer) {
        animateLabel(congratsLabel)
        guard let rocketNode = self.sceneView.scene.rootNode.childNode(withName: "Rocket", recursively: true)
            else {
                fatalError("Rocket not found")
        }
        
        guard let smokeNode = rocketNode.childNode(withName: "smokeNode", recursively: true)
            else {
                fatalError("SmokeNode not found")
        }

        smokeNode.removeAllParticleSystems()

        let fire = SCNParticleSystem(named: "art.scnassets/fire.scnp", inDirectory: nil)

        smokeNode.addParticleSystem(fire!)

        rocketNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        rocketNode.physicsBody?.isAffectedByGravity = false
        rocketNode.physicsBody?.damping = 0.0

        rocketNode.physicsBody?.applyForce(SCNVector3(0,50,0), asImpulse: false)
        
        playSound()
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "RocketSound", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
   
    
    public func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            self.startLabel.isHidden = false
            self.BackgroundView.isHidden = false
            
            self.startLabel.text = "Plane Detected"
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.startLabel.text = "Tap once to place the rocket!"
        }

    }
    
    private func animateLabel(_ label: UILabel) {
        UIView.animate(withDuration: 1.5, animations: {
            label.alpha = 1
        }, completion: nil)
    }
    
    @objc func nextBtnTapped() {
        self.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func backBtnTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}
