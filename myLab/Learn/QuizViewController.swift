//
//  QuizViewController.swift
//  myLab
//
//  Created by Metah on 10/31/20.
//

import UIKit

class QuizViewController: UIViewController {
    // MARK:- Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var continueBtn: UIButton!
    private var currentQuestion = 0
    private var selectedAnswer: Int?
    private var correctAnswers = [0, 2, 1]
    
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        continueBtn.layer.cornerRadius = 5
    }
    
    
    // MARK:- Actions
    @IBAction func close(_ sender: Any) {
        
    }
    
    @IBAction func continueQuiz(_ sender: Any) {
        guard let answer = selectedAnswer else {
            return
        }
        if answer == correctAnswers[currentQuestion] {
            currentQuestion += 1
            pageControl.currentPage = currentQuestion
        }
    }
}


extension QuizViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseID")
        return cell! 
    }
}
