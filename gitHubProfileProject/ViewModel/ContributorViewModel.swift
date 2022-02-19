//
//  ContributorViewModel.swift
//  gitHubProfileProject
//
//  Created by Kailash Jangir on 16/02/22.
//

import Foundation




protocol ContributorDelegate{
    func didFinishFetchingContributorData()
}

class ContributorViewModel{
    var contributorData = [ContributorModel]()
    var delegate: ContributorDelegate?
    var contributors: RepositoryProtocol?
    
    init(){
        contributors = FetchUserRepository()
    }
    
    // MARK: updating contributors data
    func getContributorData(user: String, repoName: String){
        contributors?.getContributorData(user: user, repoName: repoName, completionHandler: { status, data, error in
            self.contributorData.append(contentsOf: data!)
            self.delegate?.didFinishFetchingContributorData()
        })
    }
}
