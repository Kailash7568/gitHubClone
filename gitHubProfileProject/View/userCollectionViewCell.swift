//
//  userCollectionViewCell.swift
//  gitHubProfileProject
//
//  Created by Kailash Jangir on 11/02/22.
//

import UIKit

class userCollectionViewCell: UICollectionViewCell {
    
    //MARK: outlets
    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblText: UILabel!
    
    func setData(number: Int, text: String){
        lblNumber.text = String(Utilities.short(number))
        lblText.text = text
    }
    
}
