//
//  ViewController.swift
//  gitHubProfileProject
//
//  Created by Kailash Jangir on 06/02/22.
//

import UIKit
import SDWebImage


class ViewController: UIViewController, UserDelegate, RepoDelegate {
    
    //MARK: outlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblProfileName: UILabel!
    @IBOutlet weak var lblBio: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraints: NSLayoutConstraint!
    var userInput: String = ""
    let margin: CGFloat = 10
    
    
    //MARK: UserViewModel object
    var viewModelUser = UserViewModel()
    
    //MARK: UserRepositriesViewModel object
    var viewModelRepo = UserRepositriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(viewModelUser.numbers.isEmpty){
            collectionViewHeightConstraints.constant = 0
        }
        viewModelUser.delegate = self
        viewModelUser.getUserData(user: userInput)
        Utilities.roundImage(imageView: userImageView)
        Utilities.roundButton(button: followButton)
        
        viewModelRepo.delegate = self
        viewModelRepo.getRepoData(user: userInput)
        
        //MARK: collectionView Code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        
        guard let collectionView = collectionView, let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

            flowLayout.minimumInteritemSpacing = margin
            flowLayout.minimumLineSpacing = margin
            flowLayout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        //MARK: collectionView Code
        
        //MARK: tableView Code
        tableView.dataSource = self
        tableView.delegate = self
        //MARK: tableView Code
        
    }
    
    
    //MARK: Conforming protocol-delegate method didFinishFetchingUserData()
    func didFinishFetchingUserData(){
        DispatchQueue.main.async {
            self.lblUserName.text = self.viewModelUser.userData?.userName
            self.lblProfileName.text = "@"+(self.viewModelUser.userData?.profileName)!
            self.lblBio.text = self.viewModelUser.userData?.bio
            self.userImageView.sd_setImage(with: URL(string: self.viewModelUser.userData!.userImageUrl!), completed: nil)
            if(!self.viewModelUser.numbers.isEmpty){
                self.collectionViewHeightConstraints.constant = 70
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: Conforming protocol-delegate method didFinishFetchingRepoData()
    func didFinishFetchingRepoData(){
        DispatchQueue.main.async {
            if(!self.viewModelRepo.repoData.isEmpty){
                self.tableView.reloadData()
            }
        }
    }

}


//MARK: collectionView Code

//MARK: collectionView dataSource
extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModelUser.numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath as IndexPath) as! userCollectionViewCell
            cell.lblNumber.text = String(Utilities.short(self.viewModelUser.numbers[indexPath.row]))
            cell.lblText.text = self.viewModelUser.texts[indexPath.row]
            return cell
    }
    
}

//MARK: collectionView delegateFlowLayout
extension ViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = viewModelUser.numbers.count   //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
    
}
//MARK: collectionView Code



//MARK: tableView Code

//MARK: tableView delegate
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let contributorVC = storyboard?.instantiateViewController(withIdentifier: "contributorVC") as? contributorViewController{
            
            //MARK: passing userInput and repoName to contributorViewController
            contributorVC.user = userInput
            contributorVC.repoName = viewModelRepo.repoData[indexPath.row].repoName!
            
            //MARK: navigating to contributorViewController
            self.navigationController?.pushViewController(contributorVC, animated: true)
      }
    }
}


//MARK: tableView dataSource
extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelRepo.repoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath as IndexPath) as! repoTableViewCell
        cell.repoName.text = self.viewModelRepo.repoData[indexPath.row].repoName
        cell.repoDescription.text = self.viewModelRepo.repoData[indexPath.row].repoDescription
        cell.repoLanguage.text = self.viewModelRepo.repoData[indexPath.row].repoLanguage ?? "nil"
        cell.repoStars.text = String(self.viewModelRepo.repoData[indexPath.row].repoStarsCount!)
        cell.repoForks.text = String(self.viewModelRepo.repoData[indexPath.row].repoForksCount!)
        cell.repoImage.sd_setImage(with: URL(string: self.viewModelUser.userData!.userImageUrl!), completed: nil)
        cell.repoLastUpdated.text = self.viewModelRepo.repoData[indexPath.row].repoLastUpdated
        cell.repoStarButton.layer.cornerRadius = 5
        Utilities.roundImage(imageView: cell.repoImage) //MARK: to make image in the cell circular
        
        //topics
//        cell.topicTagsCollectionView.addTag(self.viewModelRepo.repoData[indexPath.row].repoTopicTags)
        //topics
        return cell
    }
}
//MARK: tableView Code
