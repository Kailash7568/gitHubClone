//
//  repoTableViewCell.swift
//  gitHubProfileProject
//
//  Created by Kailash Jangir on 13/02/22.
//

import UIKit
import TTGTags

class repoTableViewCell: UITableViewCell {
    
    //MARK: outlets
    @IBOutlet weak var repoImage: UIImageView!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoVisibility: UIImageView!
    @IBOutlet weak var repoDescription: UILabel!
    @IBOutlet weak var repoLanguage: UILabel!
    @IBOutlet weak var repoStars: UILabel!
    @IBOutlet weak var repoForks: UILabel!
    @IBOutlet weak var repoLastUpdated: UILabel!
    @IBOutlet weak var repoStarButton: UIButton!
    @IBOutlet weak var topicTagsCollectionView: TTGTextTagCollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
