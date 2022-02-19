//
//  ContributorModel.swift
//  gitHubProfileProject
//
//  Created by Kailash Jangir on 16/02/22.
//

import Foundation

struct ContributorModel : Codable {
    
    var contributorProfileName : String?
    var contributorImageUrl : String?
    
    enum CodingKeys: String, CodingKey {
        
        case contributorProfileName = "login"
        case contributorImageUrl = "avatar_url"
        
    }

}


