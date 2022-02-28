//
//  contributorTableViewCell.swift
//  gitHubProfileProject
//
//  Created by Kailash Jangir on 16/02/22.
//

import UIKit

class contributorTableViewCell: UITableViewCell {
    
    //MARK: outlets
    @IBOutlet weak var contributorImage: UIImageView!
    @IBOutlet weak var contributorProfileName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setData(contributorData: ContributorModel){
        
        contributorProfileName.text = contributorData.contributorProfileName
        contributorImage.sd_setImage(with: URL(string: contributorData.contributorImageUrl!) , completed: nil)
        //MARK: make image circular
        Utils.roundImage(imageView: contributorImage)
    }

}
