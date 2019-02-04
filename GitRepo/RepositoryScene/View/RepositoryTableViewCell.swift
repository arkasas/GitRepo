//
//  RepositoryTableViewCell.swift
//  GitRepo
//
//  Created by Arkadiusz Pituła on 03/02/2019.
//  Copyright © 2019 Arkadiusz Pituła. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet private var repoNameLabel: UILabel!
    @IBOutlet private var repoCreatedAtLabel: UILabel!
    @IBOutlet private var repoLadtUpdateLabel: UILabel!

    var repo: Repository? {
        didSet {
            repoNameLabel.text = repo?.name
            repoCreatedAtLabel.text = repo?.createdAtDate?.short
            repoLadtUpdateLabel.text = repo?.lastUpdate?.short
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
