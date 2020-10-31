//
//  SignInViewController.swift
//  myLab
//
//  Created by Баубек on 11/1/20.
//

import UIKit

class SignInViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var signInButton: UIButton!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSignInButton()
    }
   
    // MARK: - Layout
    private func setupSignInButton() {
        signInButton.layer.cornerRadius = 4
    }
}
