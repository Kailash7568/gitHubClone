//
//  MockRepositry.swift
//  gitHubProfileProjectTests
//
//  Created by Kailash Jangir on 23/02/22.
//

import Foundation
@testable import gitHubProfileProject

class FakeFetchUserRepository{
 
    //MARK: json file name
    let fileName: String
    
    init(_ fileName: String){
        self.fileName = fileName
    }
    
    enum MockingServiceError: Error{
        case user
        case repo
        case contributors
    }
    
    //MARK: fxn to read json file
    func readLocalFile(forName name: String, _ completion: @escaping ((Data?) -> Void)) {
        if let path = Bundle(for: FakeFetchUserRepository.self).path(forResource: name, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                completion(data)
            } catch _ {
                completion(nil)
            }
        }
    }
    
    //MARK: fxn to parse json(UserData)
    func parseToUser(jsonData: Data) -> UserModel? {
        do {
            let decodedData = try JSONDecoder().decode(UserModel.self, from: jsonData)
            return decodedData
        } catch {
            print("decode error in UserModel")
            return nil
        }
    }
    
    //MARK: fxn to parse json(RepoData)
    func parseToRepo(jsonData: Data) -> [UserRepositriesModel]? {
        do {
            let decodedData = try JSONDecoder().decode([UserRepositriesModel].self, from: jsonData)
            return decodedData
        } catch {
            print("decode error in UserRepositriesModel")
            return nil
        }
    }
    
    //MARK: fxn to parse json(ContributorData)
    func parseToContributor(jsonData: Data) -> [ContributorModel]? {
        do {
            let decodedData = try JSONDecoder().decode([ContributorModel].self, from: jsonData)
            return decodedData
        } catch {
            print("decode error in ContributorModel")
            return nil
        }
    }
    
}

extension FakeFetchUserRepository: RepositoryProtocol{
    
    //MARK: fxn to fetcth user Data
    func getUserData(user: String, completionHandler: @escaping (Bool, UserModel?, String?) -> Void) {
        
        readLocalFile(forName: fileName) { [weak self] data in
            guard let data = data else{
                completionHandler(false, nil, String(describing: MockingServiceError.user))
                return
            }
            if let parsedData = self?.parseToUser(jsonData: data){
                completionHandler(true, parsedData, nil)
            }
            else{
                completionHandler(false, nil, String(describing: MockingServiceError.user))
            }
        }
        
    }
    
    //MARK: fxn to fetcth Repo Data
    func getRepoData(user: String, completionHandler: @escaping (Bool, [UserRepositriesModel]?, String?) -> Void) {
        readLocalFile(forName: fileName) { [weak self] data in
            guard let data = data else{
                completionHandler(false, nil, String(describing: MockingServiceError.user))
                return
            }
            if let parsedData = self?.parseToRepo(jsonData: data){
                completionHandler(true, parsedData, nil)
            }
            else{
                completionHandler(false, nil, String(describing: MockingServiceError.user))
            }
        }
    }
    
    //MARK: fxn to fetcth Contributor Data
    func getContributorData(user: String, repoName: String, completionHandler: @escaping (Bool, [ContributorModel]?, String?) -> Void) {
        readLocalFile(forName: fileName) { [weak self] data in
            guard let data = data else{
                completionHandler(false, nil, String(describing: MockingServiceError.user))
                return
            }
            if let parsedData = self?.parseToContributor(jsonData: data){
                completionHandler(true, parsedData, nil)
            }
            else{
                completionHandler(false, nil, String(describing: MockingServiceError.user))
            }
        }
    }

}
