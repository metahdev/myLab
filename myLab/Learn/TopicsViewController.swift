//
//  TopicsViewController.swift
//  myLab
//
//  Created by Metah on 11/1/20.
//

import UIKit

class TopicsViewController: UIViewController {
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK:- Actions
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
