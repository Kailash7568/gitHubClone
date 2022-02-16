//
//  contributorViewController.swift
//  gitHubProfileProject
//
//  Created by Kailash Jangir on 16/02/22.
//

import UIKit
import SDWebImage

class contributorViewController: UIViewController, ContributorDelegate {
    
    //MARK: outlets
    @IBOutlet weak var tableView: UITableView!
    
    var user = ""
    var repoName = ""
    var viewModelContributor = ContributorViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        viewModelContributor.delegate = self
        viewModelContributor.getContributorData(user: user, repoName: repoName)
        
    }
    
    func didFinishFetchingContributorData() {
        
        DispatchQueue.main.async {
            if(!self.viewModelContributor.contributorData.isEmpty){
                self.tableView.reloadData()
            }
        }
        
    }
  
}

//MARK: tableview delegate
extension contributorViewController: UITableViewDelegate{
    
}

//MARK: tableview dataSource
extension contributorViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelContributor.contributorData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contributorCell", for: indexPath as IndexPath) as! contributorTableViewCell
        cell.contributorProfileName.text = viewModelContributor.contributorData[indexPath.row].contributorProfileName
        cell.contributorImage.sd_setImage(with: URL(string: self.viewModelContributor.contributorData[indexPath.row].contributorImageUrl!) , completed: nil)
        //MARK: make image circular
        Utilities.roundImage(imageView: cell.contributorImage)
        return cell
    }
    
}
