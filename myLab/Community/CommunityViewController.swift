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
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    // MARK:- Actions
    @IBAction func fight(_ sender: Any) {
    }
}


extension CommunityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseID") as! QuestionTableViewCell
        cell.title = "Could a parallel universe where other parallel universes do not exist, exist?"
        cell.details = "Hey everyone! Recently I've been thinking about a fun paradox: if there is an infinite count of universes, could it be possible that in one of them, others do not exist?"
        cell.points = "38"
        cell.author = "by: baubekZh"
        cell.date = "31/10/20 20:38 PM"
        cell.imageName = "bauka"
        return cell
    }
}
