//
//  ProfileViewController.swift
//  myLab
//
//  Created by Metah on 10/30/20.
//

import UIKit

class ProfileViewController: UIViewController {
    // MARK:- Properties
    @IBOutlet private weak var interestsCV: UICollectionView!
    @IBOutlet private weak var questionsTV: UITableView!
    @IBOutlet private weak var commentsTV: UITableView!
    @IBOutlet private weak var imageView: UIImageView!
    private var interests = ["Comp. Science", "Physics"]
    private var interestsImages = ["cs", "physics"]
    private var questions = ["Can anyone explain to me what is Ohm's law?", "Cambridge Exam Preparation Tips?"]
    private var questionsPoints = ["1 point", "3 points"]
    private var comments = ["Swift is way faster than Python, smh", "I think that Physics is more interesting, than..."]
    private var commentsPoints = ["1 points", "2 point"]
    
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        interestsCV.delegate = self
        interestsCV.dataSource = self
        questionsTV.delegate = self
        questionsTV.dataSource = self
        commentsTV.delegate = self
        commentsTV.dataSource = self
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.cornerRadius = imageView.frame.height * 0.5
        imageView.layer.borderWidth = 2
    }
}


extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "reuseID", for: indexPath) as! ImageCollectionViewCell
        cell.title = interests[indexPath.row]
        cell.imageName = interestsImages[indexPath.row]
        return cell
    }
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseID") as! TitleTableViewCell
        if tableView.tag == 1 {
            cell.title = questions[indexPath.row]
            cell.points = questionsPoints[indexPath.row]
        } else {
            cell.title = comments[indexPath.row]
            cell.points = commentsPoints[indexPath.row]
        }
        return cell
    }
}
