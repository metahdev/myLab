//
//  QuizViewController.swift
//  myLab
//
//  Created by Metah on 10/31/20.
//

import UIKit

class QuizViewController: UIViewController {
    // MARK:- Properties
    @IBOutlet weak var questionLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var continueBtn: UIButton!
    private var currentQuestion = 0
    private var selectedAnswer: Int?
    private var correctAnswers = [0, 2, 1]
    private var questions = ["What is formula of momentum?", "'V' in the momentum formula stands for:", "What is the mass of an object, which is moving with 2m/s velocity and has momentum equal to 10kg m/s?"]
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        continueBtn.layer.cornerRadius = 5
        updateData()
    }
    
    private func updateData() {
        pageControl.currentPage = currentQuestion
        questionLbl.text = questions[currentQuestion]
        tableView.reloadData()
    }
    
    
    // MARK:- Actions
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func continueQuiz(_ sender: Any) {
        guard let answer = selectedAnswer else {
            return
        }
        if answer == correctAnswers[currentQuestion] {
            if currentQuestion + 1 == correctAnswers.count {
                Content.currentTopicTitle = "Impulse - Linear Momentum, Conservation, Inelastic & Elastic Collisions, Force"
                Content.currentTopicImage = "impulse"
                Content.currentTopic = "Mechanics, chapter 6"
                Content.progress = 0.6
                self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                return
            }
            currentQuestion += 1
            let cell = tableView.cellForRow(at: IndexPath(row: selectedAnswer!, section: 0)) as! AnswerTableViewCell
            cell.deselectDot()
            selectedAnswer = nil
            updateData()
        } else {
            showErrorAlert()
        }
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Wrong!", message: "Sorry, it looks like your answer is wrong", preferredStyle: .alert)
        let action = UIAlertAction(title: "Try Again", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}


extension QuizViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseID") as! AnswerTableViewCell
        cell.title = Content.choises[currentQuestion][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let answer = selectedAnswer {
            let oldCell = tableView.cellForRow(at: IndexPath(row: answer, section: 0)) as! AnswerTableViewCell
            oldCell.deselectDot()
        }
        let cell = tableView.cellForRow(at: indexPath) as! AnswerTableViewCell
        cell.selectDot()
        selectedAnswer = indexPath.row
        cell.isSelected = !cell.isSelected
    }
}
