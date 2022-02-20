//
//  Repositry.swift
//  gitHubProfileProject
//
//  Created by Kailash Jangir on 18/02/22.
//

import Foundation



protocol RepositoryProtocol {
    func getUserData(user: String, completionHandler: @escaping (_ status: Bool, _ data: UserModel?, _ error: String?)->Void)
    func getRepoData(user: String, completionHandler: @escaping (_ status: Bool, _ data: [UserRepositriesModel]?, _ error: String?)->Void)
    func getContributorData(user: String, repoName: String, completionHandler: @escaping (_ status: Bool, _ data: [ContributorModel]?, _ error: String?)->Void)
}

class FetchUserRepository: RepositoryProtocol{
    
    init(){
        
    }
    
    // MARK: Fetching User Profile Data
    func getUserData(user: String, completionHandler: @escaping (_ status: Bool, _ data: UserModel?, _ error: String?)->Void){
        
        if let url = URL(string: "https://api.github.com/users/" + user){
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                if let error = error {
                    completionHandler(false, nil, error.localizedDescription)
                    return
                }
                do {
                    if let data = data{
                        let result = try JSONDecoder().decode(UserModel.self, from: data)
                        completionHandler(true, result, nil)
                    }
                    
                } catch {
                    completionHandler(false, nil, error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    // MARK: Fetching User Repo Data
    func getRepoData(user: String,  completionHandler: @escaping (_ status: Bool, _ data: [UserRepositriesModel]?, _ error: String?)->Void){
        
        if let url = URL(string: "https://api.github.com/users/" + user + "/repos"){
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                if let error = error {
                    completionHandler(false, nil, error.localizedDescription)
                    return
                }
                do {
                    if let data = data {
                        let result = try JSONDecoder().decode([UserRepositriesModel].self, from: data)
                        completionHandler(true, result, nil)
                    }
                    
                } catch {
                    completionHandler(false, nil, error.localizedDescription)
                }
            }
            task.resume()
        }
    }
    
    //MARK: Fetching contributors data
    func getContributorData(user: String, repoName: String, completionHandler: @escaping (_ status: Bool, _ data: [ContributorModel]?, _ error: String?)->Void){
       
        if let url = URL(string:"https://api.github.com/repos/" + user + "/" + repoName + "/contributors"){
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let error = error {
                    completionHandler(false, nil, error.localizedDescription)
                    return
                }
                do {
                    if let data = data {
                        let result = try JSONDecoder().decode([ContributorModel].self, from: data)
                        completionHandler(true, result, nil)
                    }
                    
                } catch {
                    completionHandler(false, nil, error.localizedDescription)
                }
            }
            task.resume()
        }
        
    }
}

