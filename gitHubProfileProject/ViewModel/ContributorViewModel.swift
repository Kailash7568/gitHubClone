//
//  ContributorViewModel.swift
//  gitHubProfileProject
//
//  Created by Kailash Jangir on 16/02/22.
//

import Foundation




protocol ContributorDelegate{
    func didFinishFetchingContributorData()
    func didNotFinishFetchingContributorData()
}

class ContributorViewModel{
    var contributorData = [ContributorModel]()
    var delegate: ContributorDelegate?
    var contributors: RepositoryProtocol?
    var errorInfetchingContributors = false
    
    init(repositry: RepositoryProtocol){
        contributors = repositry
    }
    
    // MARK: updating contributors data
    func getContributorData(user: String, repoName: String){
        contributors?.getContributorData(user: user, repoName: repoName, completionHandler: { status, data, error in
            if let data = data {
                self.errorInfetchingContributors = false
                self.contributorData = data
                self.delegate?.didFinishFetchingContributorData()
            } else{
                self.errorInfetchingContributors = true
                self.delegate?.didNotFinishFetchingContributorData()
            }
        })
    }
}
