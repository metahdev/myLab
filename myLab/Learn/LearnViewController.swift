//
//  LearnViewController.swift
//  myLab
//
//  Created by Metah on 10/30/20.
//

import UIKit

class LearnViewController: UIViewController {
    // MARK:- Properties
    @IBOutlet weak var currentTopicTitleLbl: UILabel!
    @IBOutlet weak var currentTopicLbl: UILabel!
    @IBOutlet weak var currentTopicIV: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet private weak var subjectsCV: UICollectionView!
    @IBOutlet private weak var learnedTV: UITableView!
    
    private var topics = ["Physics(extracurriculum): what is time?", "Biology: animal cell structure", "Chemistry: oxidation reaction", "Computer Science: types of network"]
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        subjectsCV.delegate = self
        subjectsCV.dataSource = self
        learnedTV.delegate = self
        learnedTV.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentTopicTitleLbl.text = Content.currentTopicTitle
        currentTopicIV.image = UIImage(named: Content.currentTopicImage)
        currentTopicLbl.text = Content.currentTopic
        progressView.progress = Content.progress
    }
    
    
    // MARK:- Actions
    @IBAction func showTopic() {
        performSegue(withIdentifier: "continue", sender: nil)
    }
}


extension LearnViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseID", for: indexPath) as! ImageCollectionViewCell
        cell.title = Content.subjects[indexPath.row]
        cell.imageName = Content.subjectsImages[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "topics", sender: nil)
    }
}


extension LearnViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseID") as! TitleTableViewCell
        cell.title = topics[indexPath.row]
        return cell
    }
}
