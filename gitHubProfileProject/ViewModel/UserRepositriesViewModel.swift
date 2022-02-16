//
//  UserRepositriesViewModel.swift
//  gitHubProfileProject
//
//  Created by Kailash Jangir on 12/02/22.
//

import Foundation



protocol RepoDelegate
{
    func didFinishFetchingRepoData()
}


class UserRepositriesViewModel{
    
    var repoData = [UserRepositriesModel]() //variable to store repositries information
    var delegate: RepoDelegate?
    
    //===================fetch data using userResponse==============//
    func getRepoData(user: String){
        let url = URL(string: "https://api.github.com/users/" + user + "/repos")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            do{
                let userResponse = try JSONDecoder().decode([UserRepositriesModel].self, from: data!)
                self.repoData.append(contentsOf: userResponse)
                self.delegate?.didFinishFetchingRepoData()
            } catch{
                let error = error
                print(error.localizedDescription)
            }
            
        }.resume()
        
    }
    
}
