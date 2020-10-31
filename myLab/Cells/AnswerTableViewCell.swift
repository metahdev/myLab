//
//  AnswerTableViewCell.swift
//  myLab
//
//  Created by Metah on 10/31/20.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {
    // MARK:- Properties
    var title = "" {
        didSet {
            titleLabel.text = title
        }
    }
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    

    // MARK:- Initialization
    override func awakeFromNib() {
        dotButton.layer.borderColor = UIColor.black.cgColor
        dotButton.layer.borderWidth = 1
        dotButton.layer.cornerRadius = dotButton.frame.width * 0.5
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // MARK:- Helpful methods
    func selectDot() {
        dotButton.backgroundColor = .black
    }
    
    func deselectDot() {
        dotButton.backgroundColor = .clear
    }
}
