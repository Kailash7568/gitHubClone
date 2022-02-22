//
//  repoTableViewCell.swift
//  gitHubProfileProject
//
//  Created by Kailash Jangir on 13/02/22.
//

import UIKit
import TagListView

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
    @IBOutlet weak var topicTagsView: TagListView!
    @IBOutlet weak var repoLanguageCircle: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        topicTagsView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    //MARK: fxn to set repositries information in tableview cell
    func setData(repoData: UserRepositriesModel){
        repoName.text = repoData.repoName
        repoDescription.text = repoData.repoDescription
        if repoData.repoLanguage == nil{
            repoLanguage.isHidden = true
            repoLanguageCircle.isHidden = true
        }else{
            repoLanguage.text = repoData.repoLanguage
        }
        repoStars.text = Utilities.short(repoData.repoStarsCount ?? 0)
        repoForks.text = Utilities.short(repoData.repoForksCount ?? 0)
        repoLastUpdated.text = Utilities.dateDifference(repoDate: repoData.repoLastUpdated ?? "")
        repoStarButton.layer.cornerRadius = 5
        repoImage.sd_setImage(with: URL(string: "https://cdn-icons-png.flaticon.com/512/25/25231.png"), completed: nil)
        if(repoData.repoTopicTags?.count != 0){
            self.topicTagsView.removeAllTags()
            topicTagsView.addTags(repoData.repoTopicTags ?? [])
        }else{
            topicTagsView.isHidden = true
        }
        Utilities.roundImage(imageView: repoImage) //MARK: to make image in the cell circular
    }

}

extension repoTableViewCell: TagListViewDelegate{
    
}
