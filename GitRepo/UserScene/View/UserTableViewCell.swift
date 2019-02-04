//
//  UserTableViewCell.swift
//  GitRepo
//
//  Created by Arkadiusz Pituła on 03/02/2019.
//  Copyright © 2019 Arkadiusz Pituła. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet private var avatarImageView: UIImageView!
    @IBOutlet private var userNameLabel: UILabel!

    var avatar: UIImage? {
        didSet {
            avatarImageView.image = avatar
        }
    }

    var userName: String? {
        didSet {
            userNameLabel.text = userName
        }
    }

    var avatarURL: String = "" {
        didSet {
            avatarImageView.downloaded(from: avatarURL)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
