//
//  LoadingViewController.swift
//  myLab
//
//  Created by Metah on 11/1/20.
//

import UIKit

class LoadingViewController: UIViewController {
    // MARK:- Properties
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var searchingLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var timerLbl: UILabel!
    @IBOutlet weak var opponentLbl: UILabel!
    @IBOutlet weak var opponentNameLbl: UILabel!
    private var counter = 5
    private var timer: Timer!
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5, execute: {
            self.startFight()
        })
    }
    
    private func startFight() {
        showViews()
        animateIV()
        startTimer()
    }
    
    private func showViews() {
        searchingLbl.isHidden = true
        activityIndicator.isHidden = true
        imageView.isHidden = false
        timerLbl.isHidden = false
        opponentLbl.isHidden = false
        opponentNameLbl.isHidden = false
    }
    
    private func animateIV() {
        imageView.center.x += 350
        UIView.animate(withDuration: 0.1, animations: {
            self.imageView.center.x -= 350
        })
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
    }
    
    @objc
    private func updateLabel() {
        counter -= 1
        timerLbl.text = "Starting after: \(counter) seconds"
        if counter == 0 {
            timer.invalidate()
            performSegue(withIdentifier: "fight", sender: nil)
        }
    }
    
    
    // MARK:- Actions
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
