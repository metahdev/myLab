//
//  TopicViewController.swift
//  myLab
//
//  Created by Metah on 10/31/20.
//

import UIKit
import youtube_ios_player_helper

class TopicViewController: UIViewController {
    // MARK:- Properties
    @IBOutlet weak var firstTV: UITextView!
    @IBOutlet weak var secondTV: UITextView!
    @IBOutlet weak var videoView: YTPlayerView! 
    @IBOutlet weak var importantTV: UITextView!
    @IBOutlet weak var continueBtn: UIButton!
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        firstTV.layer.cornerRadius = 5
        secondTV.layer.cornerRadius = 5
        videoView.layer.cornerRadius = 5
        importantTV.layer.cornerRadius = 10
        continueBtn.layer.cornerRadius = 5
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.videoView.load(withVideoId: "XFhntPxow0U")
        }
    }
    
    
    // MARK:- Actions
    @IBAction func showAR(_ sender: Any) {
        let controller = LessonInfoViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func continueToQuiz(_ sender: Any) {
        performSegue(withIdentifier: "quizID", sender: nil)
    }
    
    @IBAction func close(_ sender: Any) {
        
    }
}
