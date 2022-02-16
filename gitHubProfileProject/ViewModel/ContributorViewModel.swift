//
//  ContributorViewModel.swift
//  gitHubProfileProject
//
//  Created by Kailash Jangir on 16/02/22.
//

import Foundation


protocol ContributorDelegate
{
    func didFinishFetchingContributorData()
}


class ContributorViewModel{
    
    var contributorData = [ContributorModel]() //variable to store repositries information
    var delegate: ContributorDelegate?
    
    //===================fetch data using userResponse==============//
    func getContributorData(user: String, repoName: String){
        let url = URL(string: "https://api.github.com/repos/" + user + "/" + repoName + "/contributors")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            do{
                let userResponse = try JSONDecoder().decode([ContributorModel].self, from: data!)
                self.contributorData.append(contentsOf: userResponse)
                self.delegate?.didFinishFetchingContributorData()
            } catch{
                let error = error
                print(error.localizedDescription)
            }
            
        }.resume()
        
    }
    
}
