//
//  QuestionViewController.swift
//  myLab
//
//  Created by Metah on 11/1/20.
//

import UIKit

class QuestionViewController: UIViewController {
    // MARK:- Properties
    @IBOutlet weak var tableView: UITableView!
    
    
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

extension QuestionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseID") as! QuestionTableViewCell
        cell.details = "I don't think so, because even parallel universes have to be based on physics rules, plus it is just illogical that this kind of possibility could be."
        cell.points = "1"
        cell.author = "by: sangikkk"
        cell.date = "31/10/20 21:07 PM"
        cell.imageName = "sangikkk"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "question", sender: nil)
    }
}
