//
//  CommunityViewController.swift
//  myLab
//
//  Created by Metah on 10/30/20.
//

import UIKit

class CommunityViewController: UIViewController {
    // MARK:- Properties
    @IBOutlet weak var tableView: UITableView!
    private var titles = ["Could a parallel universe where other parallel universes do not exist, exist?", "What is the simplest way to describe Molecular-Kinetic theory?"]
    private var details = ["Hey everyone! Recently I've been thinking about a fun paradox: if there is an infinite count of universes, could it be possible that in one of them, others do not exist?", "Hi there! My youngest brother asked what am I currenly learning at my Physics class. What is the simplest way of describing Molecular-Kinetic theory?"]
    private var points = ["2", "3"]
    private var authors = ["by: baubekZh", "by: sangikkk"]
    private var dates = ["31/10/20 20:38 PM", "31/10/20 20:02 PM"]
    private var imageNames = ["bauka", "sangikkk"]
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    // MARK:- Actions
    @IBAction func fight(_ sender: Any) {
        performSegue(withIdentifier: "fight", sender: nil)
    }
}


extension CommunityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseID") as! QuestionTableViewCell
        cell.title = titles[indexPath.row]
        cell.details = details[indexPath.row]
        cell.points = points[indexPath.row]
        cell.author = authors[indexPath.row]
        cell.date = dates[indexPath.row]
        cell.imageName = imageNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        cell.isSelected = !cell.isSelected
        performSegue(withIdentifier: "question", sender: nil)
    }
}
