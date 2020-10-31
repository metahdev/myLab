//
//  LessonInfoViewController.swift
//  Momentum
//
//  Created by Баубек on 10/30/20.
//

import UIKit

enum LessonInfo {
    case car
    case rocket
    case collision
}

protocol LessonInfoViewControllerProtocol: class {
    var textViewContent: NSMutableAttributedString! { get set }
    var image: UIImage! { get set }
}

class LessonInfoViewController: UIViewController, LessonInfoViewControllerProtocol {
    // MARK: - Properties
    var textViewContent: NSMutableAttributedString! = {
        let mainText = "Momentum\nAll moving objects have momentum and momentum is a vector. Objects that are not moving have no momentum.\n\nThe word equation\nmomentum = mass x velocity\n\nThe symbol equation\np = m x v\n\nQuestion\nThe car has a mass of 100kg and is not moving. How much is the momentum of the car in kg m/s?\n\nReminder\n- Use the equation above to help you\n- You may move around with your finger to view the car"
        let textToColor = "Momentum"
        let mutableAttribute = NSMutableAttributedString(string: "Momentum\nAll moving objects have momentum and momentum is a vector. Objects that are not moving have no momentum.\n\nThe word equation\nmomentum = mass x velocity\n\nThe symbol equation\np = m x v\n\nQuestion\nThe car has a mass of 100kg and is not moving. How much is the momentum of the car in kg m/s?\n\nReminder\n- Use the equation above to help you\n- You may move around with your finger to view the car", attributes: [NSAttributedString.Key.font: UIFont(name: "Optima Regular", size: 18)!])
        mutableAttribute.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 20), range: NSRange(location: 0, length: 8))
        mutableAttribute.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 18), range: NSRange(location: 115, length: 17))
        mutableAttribute.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 18), range: NSRange(location: 161, length: 19))
        mutableAttribute.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 22), range: NSRange(location: 192, length: 8))
        mutableAttribute.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 18), range: NSRange(location: 295, length: 9))
        return mutableAttribute
    }()
    var image: UIImage! = UIImage(named: "CarPhoto")
        
    private lazy var nextBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "next"), for: .normal)
        btn.addTarget(self, action: #selector(nextBtnTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.contentSize = CGSize(width: view.frame.width, height: textView.frame.height + answerLabel.frame.height + 4)
        return sv
    }()
    
    private lazy var textView: UITextView = {
        let tv = UITextView()
        tv.textColor = .black
        tv.backgroundColor = .clear
        tv.sizeToFit()
        tv.isEditable = false
        tv.isScrollEnabled = false
        return tv
    }()
    
    private lazy var answerLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Optima Regular", size: 18)
        lbl.textColor = .black
        lbl.text = "momentum = "
        return lbl
    }()
    
    private lazy var answerTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont(name: "Open Sans", size: view.frame.height * 0.04)
        tf.keyboardType = .numberPad
        tf.layer.borderWidth = 1
        tf.layer.borderColor = UIColor.black.cgColor
        tf.layer.cornerRadius = 2
        tf.backgroundColor = .lightGray
        tf.textColor = .black
        return tf
    }()
    
    private lazy var backBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "back"), for: .normal)
        btn.addTarget(self, action: #selector(backBtnTapped), for: .touchUpInside)
        return btn
    }()
    
    private lazy var imageView = UIImageView()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textView.attributedText = textViewContent
        imageView.image = image
    }
    
    // MARK: - Layout
    private func setupLayout() {
        addSubviews()
        makeMaskFalse()
        activateConstraints()
    }
    
    private func addSubviews() {
        [imageView, nextBtn, textView, answerLabel, answerTextField, backBtn].forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func makeMaskFalse() {
        [nextBtn, textView, answerLabel, answerTextField, imageView, backBtn].forEach { subview in
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            nextBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nextBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            nextBtn.widthAnchor.constraint(equalToConstant: 40),
            nextBtn.heightAnchor.constraint(equalToConstant: 30),
            
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.24),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor),
            
            answerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 4),
            answerLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            
            answerTextField.leadingAnchor.constraint(equalTo: answerLabel.trailingAnchor, constant: 2),
            answerTextField.heightAnchor.constraint(equalTo: answerLabel.heightAnchor),
            answerTextField.topAnchor.constraint(equalTo: answerLabel.topAnchor),
            answerTextField.widthAnchor.constraint(equalToConstant: 60),
            
            textView.leadingAnchor.constraint(equalTo: answerLabel.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -4),
            textView.topAnchor.constraint(equalTo: answerLabel.bottomAnchor, constant: 6),
            
            backBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            backBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backBtn.widthAnchor.constraint(equalToConstant: 30),
            backBtn.heightAnchor.constraint(equalTo: backBtn.widthAnchor)
        ])
    }
    
    
    //MARK: - Actions
    @objc func nextBtnTapped() {
        let carViewController = CarARViewController()
        let rocketViewController = RocketARViewController()
        carViewController.modalPresentationStyle = .fullScreen
        rocketViewController.modalPresentationStyle = .fullScreen
        if imageView.image == UIImage(named: "CarPhoto") {
            if answerTextField.text == "0" {
                carViewController.resultText = "Whoa! You have learned the definition of momentum. You can move to next page and continue your momentum journey."
            } else {
                carViewController.resultText = "Fail! Because we are finding the momentum of the car, we need to apply the equation: momentum = mass x velocity = 100kg x 0m/s. momentum = 0"
            }
            present(carViewController, animated: true, completion: nil)
        } else if imageView.image == UIImage(named: "LaunchRocket") {
            if answerTextField.text == "5000" {
                rocketViewController.resultText = "Well done! You have learned the definition of momentum. You can move to next page."
            } else {
                rocketViewController.resultText = "Fail! The equation to calculate momentum is momentum = mass x velocity = 1000kg x 5m/s. let momentum = 5000"
            }
            present(rocketViewController, animated: true, completion: nil)
        } 
    }
    
    @objc func backBtnTapped() {
        dismiss(animated: true, completion: nil)
    }

}
