//
//  EntryViewController.swift
//  myLab
//
//  Created by Metah on 10/29/20.
//

import UIKit

class EntryViewController: UIViewController {
    // MARK:- Properties
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var detailsLabel: UILabel!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var nextBtn: UIButton!
    private lazy var rightSwipeGesture: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(previousSlide))
        swipe.direction = .right
        return swipe
    }()
    private lazy var leftSwipeGesture: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextSlide))
        swipe.direction = .left
        return swipe
    }()
    private var index = 0
        
    
    // MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearence()
        updateValues()
        addGestures()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateTransition()
    }
    
    private func setupAppearence() {
        nextBtn.layer.cornerRadius = 5
        pageControl.numberOfPages = Content.entryTitles.count
    }
    
    private func updateValues() {
        titleLabel.text = Content.entryTitles[index]
        detailsLabel.text = Content.entryDescription[index]
        imageView.image = UIImage(named: Content.entryImages[index])
        pageControl.currentPage = index
    }
    
    private func addGestures() {
        view.addGestureRecognizer(rightSwipeGesture)
        view.addGestureRecognizer(leftSwipeGesture)
    }
    
    
    // MARK:- Actions
    @objc
    private func nextSlide() {
        guard index != Content.entryTitles.count - 1 else {
            closeView()
            return
        }
        index += 1
        updateValues()
        animateTransition()
    }
    
    @objc
    private func previousSlide() {
        guard index != 0 else {
            return
        }
        index -= 1
        updateValues()
        animateTransition()
    }
    
    @IBAction func nextBtnIsPressed(_ sender: Any) {
        nextSlide()
    }
    
    @IBAction func skip(_ sender: Any) {
        closeView()
    }
    
    private func closeView() {
        UserDefaults.standard.set(1, forKey: Constants.entryKey)
        performSegue(withIdentifier: "toMain", sender: nil)
    }
    
    
    // MARK:- Animation
    private func animateTransition() {
        setBeginningValues()
        UIView.animate(withDuration: 0.5, animations: {
            self.setEndingValues()
        })
    }
    
    private func setBeginningValues() {
        self.titleLabel.alpha = 0
        self.imageView.alpha = 0
        self.imageView.frame.origin.y -= 50
        self.detailsLabel.alpha = 0
    }
    
    private func setEndingValues() {
        self.imageView.frame.origin.y += 50
        self.titleLabel.alpha = 1
        self.imageView.alpha = 1
        self.detailsLabel.alpha = 1
    }
}

