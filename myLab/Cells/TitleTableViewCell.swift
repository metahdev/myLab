//
//  TitleTableViewCell.swift
//  myLab
//
//  Created by Metah on 10/31/20.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    // MARK:- Properties
    var title = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var points = "" {
        didSet {
            pointsLabel.text = points
        }
    }
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var pointsLabel: UILabel!
    
    
    // MARK:- Class Methods 
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
