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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setData(repoData: UserRepositriesModel){
        repoName.text = repoData.repoName
        repoDescription.text = repoData.repoDescription
        repoLanguage.text = repoData.repoLanguage ?? "nil"
        repoStars.text = String(repoData.repoStarsCount!)
        repoForks.text = String(repoData.repoForksCount!)
        repoLastUpdated.text = Utilities.dateDifference(repoDate: repoData.repoLastUpdated!)
        repoStarButton.layer.cornerRadius = 5
        repoImage.sd_setImage(with: URL(string: "https://cdn-icons-png.flaticon.com/512/25/25231.png"), completed: nil)
        Utilities.roundImage(imageView: repoImage) //MARK: to make image in the cell circular
    }

}
