//
//  UserRepositriesModel.swift
//  gitHubProfileProject
//
//  Created by Kailash Jangir on 12/02/22.
//

import Foundation

struct UserRepositriesModel : Codable {
    var repoName : String?
    var repoDescription : String?
    var repoLastUpdated : String?
    var repoLanguage : String?
    var isRepoPrivate : Bool?
    var repoForksCount : Int?
    var repoStarsCount : Int?
    var repoTopicTags : [String]?
    
    enum CodingKeys: String, CodingKey {
        case repoName = "name"
        case repoDescription = "description"
        case repoLastUpdated = "updated_at"
        case repoLanguage = "language"
        case isRepoPrivate = "private"
        case repoForksCount = "forks_count"
        case repoStarsCount = "stargazers_count"
        case repoTopicTags = "topics"
    }
}
