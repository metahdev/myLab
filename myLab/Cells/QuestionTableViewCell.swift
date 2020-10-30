//
//  QuestionTableViewCell.swift
//  myLab
//
//  Created by Metah on 10/31/20.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    // MARK:- Properties
    var title = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var details = "" {
        didSet {
            detailLabel.text = details
        }
    }
    var date = "" {
        didSet {
            timeLabel.text = date
        }
    }
    var points = "" {
        didSet {
            pointsLabel.text = points
        }
    }
    var author = "" {
        didSet {
            authorLabel.text = author
        }
    }
    var imageName = "" {
        didSet {
            authorIV.image = UIImage(named: imageName)
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var authorIV: UIImageView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    // MARK:- Initialization
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
