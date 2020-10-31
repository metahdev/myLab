//
//  ChoiceViewController.swift
//  myLab
//
//  Created by Metah on 11/1/20.
//

import UIKit

class ChoiceViewController: UIViewController {
    // MARK:- Properties
    @IBOutlet private weak var subjectsCV: UICollectionView!

    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        subjectsCV.delegate = self
        subjectsCV.dataSource = self
    }
    
    
    // MARK:- Actions
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension ChoiceViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
        performSegue(withIdentifier: "loading", sender: nil)
    }
}
