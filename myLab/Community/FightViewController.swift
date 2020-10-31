//
//  FightViewController.swift
//  myLab
//
//  Created by Metah on 11/1/20.
//

import UIKit

class FightViewController: UIViewController {
    // MARK:- Properties
    @IBOutlet weak var tableView: UITableView!
    private var selectedAnswer: Int?
    private var choises = ["F = P/V(power/velocity)", "F = mgh", "F = ma", "F = mV^2/r"]
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    // MARK:- Actions
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension FightViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseID") as! AnswerTableViewCell
        cell.title = choises[indexPath.row]
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
