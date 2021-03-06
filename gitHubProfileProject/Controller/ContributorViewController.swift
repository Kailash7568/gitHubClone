//
//  contributorViewController.swift
//  gitHubProfileProject
//
//  Created by Kailash Jangir on 16/02/22.
//

import UIKit
import SDWebImage

class ContributorViewController: UIViewController, ContributorDelegate {
    
    //MARK: outlets
    @IBOutlet weak var contributorTableView: UITableView!
    @IBOutlet weak var contributorsNotFoundView: UIView!
    
    
    var user = ""
    var repoName = ""
    var viewModelContributor = ContributorViewModel(repositry: HomeViewController.repositryObj)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        contributorTableView.delegate = self
        contributorTableView.dataSource = self
        viewModelContributor.delegate = self
        viewModelContributor.getContributorData(user: user, repoName: repoName)
        title = "Contributors"
        
    }
    
    func didFinishFetchingContributorData() {
        
        DispatchQueue.main.async {
            if(!self.viewModelContributor.contributorData.isEmpty){
                self.contributorTableView.reloadData()
            } else{
                //MARK: if there is no Contributor
                self.contributorsNotFoundView.isHidden = false   //Kudoleh
            }
        }
        
    }
    
    func didNotFinishFetchingContributorData() {
        DispatchQueue.main.async {
            //MARK: if there is no Contributor
            self.contributorsNotFoundView.isHidden = false
        }
    }
  
}

//MARK: tableview delegate
extension ContributorViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let homeVC = storyboard?.instantiateViewController(withIdentifier: "homeVC") as? HomeViewController{
            
            //MARK: using userName of contributor and pass that to homeView Controller
            homeVC.userInput = viewModelContributor.contributorData[indexPath.row].contributorProfileName
            
            
            //MARK: navigating to contributorViewController
            self.navigationController?.pushViewController(homeVC, animated: true)
      }
    }
    
}

//MARK: tableview dataSource
extension ContributorViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelContributor.contributorData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contributorCell", for: indexPath as IndexPath) as! contributorTableViewCell
        
        let contributorData = viewModelContributor.contributorData[indexPath.row]
        cell.setData(contributorData: contributorData)
        return cell
    }
    
}
