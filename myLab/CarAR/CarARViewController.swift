//
//  IntroViewController.swift
//  WWDC19
//
//  Created by Aaron Cheung 430 on 15/3/2019.
//  Copyright © 2019 Aaron Cheung 430. All rights reserved.
//

import UIKit
import SceneKit

protocol CarViewControllerProtocol: class {
    var resultText: String! { get set }
}

public class CarARViewController: UIViewController {
    // MARK: - Properties
    var resultText: String!
    
    private lazy var sceneView: SCNView = SCNView()
    private lazy var nextBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "next"), for: .normal)
        btn.addTarget(self, action: #selector(nextBtnTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
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
        return lbl
    }()
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = sceneView
        
        let scene = SCNScene(named: "art.scnassets/car.scn")!
        
        sceneView.scene = scene
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        setupLayout()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resultLabel.text = resultText
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateResultLabel()
    }
    
    // MARK: - Layout
    private func setupLayout() {
        addSubviews()
        makeMaskFalse()
        activateConstraints()
    }
    
    private func addSubviews() {
        [resultLabel, nextBtn, backBtn].forEach { (subview) in
            view.addSubview(subview)
        }
    }
    private func makeMaskFalse() {
        [resultLabel, nextBtn, backBtn].forEach { (subview) in
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nextBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            nextBtn.widthAnchor.constraint(equalToConstant: 40),
            nextBtn.heightAnchor.constraint(equalToConstant: 50),
            
            resultLabel.bottomAnchor.constraint(equalTo: nextBtn.topAnchor, constant: -10),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            backBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backBtn.widthAnchor.constraint(equalToConstant: 30),
            backBtn.heightAnchor.constraint(equalTo: backBtn.widthAnchor)
        ])
    }
    
    private func animateResultLabel() {
        UIView.animate(withDuration: 1.5, animations: {
            self.resultLabel.alpha = 1
        }, completion: nil)
    }
    
    // MARK: - Actions
    @objc func nextBtnTapped() {
        let mutableAttribute = NSMutableAttributedString(string: "Launching Rocket 🚀 with Momentum\n Do you know rockets have momentum too? Try to use the knowledge you have learnt in the previous pages, and answer the question below.\n\nQuestion\nThe rocket has a mass of 1000 kg and is moving at 5m/s. How much is the momentum of the rocket in kg m/s?\n\nReminder\n- Find a plane first.\n- Tap the screen once to place the rocket\n- Tap the screen twice to launch the rocket", attributes: [NSAttributedString.Key.font: UIFont(name: "Optima Regular", size: 18)!])
        mutableAttribute.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 22), range: NSRange(location: 0, length: 33))
        mutableAttribute.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 22), range: NSRange(location: 170, length: 8))
        mutableAttribute.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 20), range: NSRange(location: 286, length: 8))
        let controller = LessonInfoViewController()
        controller.modalPresentationStyle = .fullScreen
        controller.textViewContent = mutableAttribute
        controller.image = UIImage(named: "LaunchRocket")
        show(controller, sender: nil)
    }
    
    @objc func backBtnTapped() {
        dismiss(animated: true, completion: nil)
    }
}
