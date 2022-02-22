//
//  GreenRobotViewModel.swift
//  gitHubProfileProject
//
//  Created by Kailash Jangir on 06/02/22.
//

import Foundation



protocol GitUserProfileDelegate{
    func didFinishFetchingUserData()
    func didFinishFetchingRepoData()
}

class GitUserProfileViewModel{
    // MARK: Stored Properties
    var delegate: GitUserProfileDelegate? //MARK: GitUserProfileDelegate refernce
    var repository: RepositoryProtocol? //MARK: RepositoryProtocol reference
    var repoData = [UserRepositriesModel]() //MARK: to store repositries data
    var userData: UserModel? //MARK: to store user data
    let userInfoTexts = ["repositories", "stars", "followers", "following"]
    var userInfoNumbers = [Int]()
    
    init(repositry: RepositoryProtocol){
        self.repository = repositry
    }
    
    // MARK: Updating user data
    func getUserData(user: String){
        repository?.getUserData(user: user) {[weak self] (status, data, error) in
            if status{
                self?.userData = data
                self?.userInfoNumbers.append((self?.userData?.repositories ?? 0))
                self?.userInfoNumbers.append(Int.random(in: 1000...100000))
                self?.userInfoNumbers.append((self?.userData?.followers ?? 0))
                self?.userInfoNumbers.append((self?.userData?.following ?? 0))
                self?.delegate?.didFinishFetchingUserData()
            }
            else{
                print(error ?? "System Error")
            }
        }
        
    }
    
    // MARK: Updating repo data
    func getRepoData(user: String){
        repository?.getRepoData(user: user) {[weak self] (status, data, error) in
            if status {
                if let data = data {
                    self?.repoData.append(contentsOf: data)
                    self?.delegate?.didFinishFetchingRepoData()
                }
            }
            else{
                print(error ?? "System Error")
            }
        }
        
    }
}





















//
//protocol UserDelegate
//{
//    func didFinishFetchingUserData()
//}
//
//class UserViewModel{
//
//    var userData: UserModel? //variable to store user information
//    var delegate: UserDelegate?
//    var numbers = [Int]()
//    var texts = ["repositories", "stars", "followers", "following"]
//
//    //===================fetch data using userResponse==============//
//    func getUserData(user: String){
//        let url = URL(string: "https://api.github.com/users/" + user)!
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//
//            do{
//                let userResponse = try JSONDecoder().decode(UserModel.self, from: data!)
//                self.userData = userResponse
//                self.numbers.append(self.userData?.repositories ?? 0)
//                self.numbers.append(Int.random(in: 1000...100000))
//                self.numbers.append(self.userData?.followers ?? 0)
//                self.numbers.append(self.userData?.following ?? 0)
//                self.delegate?.didFinishFetchingUserData()
//            } catch{
//                let error = error
//                print(error.localizedDescription)
//            }
//
//        }.resume()
//
//    }
//
//
//}
