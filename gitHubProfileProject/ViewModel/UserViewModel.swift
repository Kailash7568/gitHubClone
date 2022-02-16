//
//  GreenRobotViewModel.swift
//  gitHubProfileProject
//
//  Created by Kailash Jangir on 06/02/22.
//

import Foundation

protocol UserDelegate
{
    func didFinishFetchingUserData()
}

class UserViewModel{
    
    var userData: UserModel? //variable to store user information
    var delegate: UserDelegate?
    var numbers = [Int]()
    var texts = ["repositories", "stars", "followers", "following"]
    
    //===================fetch data using userResponse==============//
    func getUserData(user: String){
        let url = URL(string: "https://api.github.com/users/" + user)!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            do{
                let userResponse = try JSONDecoder().decode(UserModel.self, from: data!)
                self.userData = userResponse
                self.numbers.append(self.userData?.repositories ?? 0)
                self.numbers.append(Int.random(in: 1000...100000))
                self.numbers.append(self.userData?.followers ?? 0)
                self.numbers.append(self.userData?.following ?? 0)
                self.delegate?.didFinishFetchingUserData()
            } catch{
                let error = error
                print(error.localizedDescription)
            }
            
        }.resume()
        
    }
    
    
}
