//
//  ViewController.swift
//  gitHubProfileProject
//
//  Created by Kailash Jangir on 06/02/22.
//

import UIKit
import SDWebImage


class HomeViewController: UIViewController, GitUserProfileDelegate {
    
    //MARK: outlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelBio: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var userNotFoundView: UIView!
    
    var userInput: String = ""
    let margin: CGFloat = 10
    
    
    //MARK: GitUserProfileViewModel object
    static let repositryObj = FetchUserRepository()
    var viewModelUser = GitUserProfileViewModel(repositry: repositryObj)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModelUser.delegate = self
        viewModelUser.getUserData(user: userInput)
        viewModelUser.getRepoData(user: userInput)
        
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
        homeTableView.dataSource = self
        homeTableView.delegate = self
        //MARK: tableView Code
        
        //MARK: Make height of collectionView containing userInfo zero when there is no userInfo
        if(viewModelUser.userInfoNumbers.isEmpty){
            collectionViewHeightConstraints.constant = 0
        }
        
        Utils.roundImage(imageView: userImageView)
        Utils.roundButton(button: followButton)
        
    }
    
    
    //MARK: Conforming protocol-delegate method didFinishFetchingUserData()
    func didFinishFetchingUserData(){
        DispatchQueue.main.async {
            guard let userName = self.viewModelUser.userData?.userName else {
                return
            }
            self.homeTableView.isHidden = false
            self.labelUserName.text = "@" + userName
            self.labelName.text = self.viewModelUser.userData?.name
            self.labelBio.text = self.viewModelUser.userData?.bio
            guard let userImage = self.viewModelUser.userData?.userImageUrl else { return }
            self.userImageView.sd_setImage(with: URL(string: userImage), completed: nil)
            if(!self.viewModelUser.userInfoNumbers.isEmpty){
                self.collectionViewHeightConstraints.constant = 70
                self.collectionView.reloadData()
            }
        }
    }
    
    func didNotFetchUserData() {
        DispatchQueue.main.async {
            //MARK: if there is no valid user present
            self.userNotFoundView.isHidden = false
        }
    }
    
    //MARK: Conforming protocol-delegate method didFinishFetchingRepoData()
    func didFinishFetchingRepoData(){
        DispatchQueue.main.async {
            if(!self.viewModelUser.repoData.isEmpty){
                self.homeTableView.reloadData()
            }
        }
    }
    
    func didNotFetchRepoData() {
        
    }
    
    
}


//MARK: userInfo collectionView dataSource
extension HomeViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModelUser.userInfoNumbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath as IndexPath) as! userCollectionViewCell
        
        let number = viewModelUser.userInfoNumbers[indexPath.row]
        let text = viewModelUser.userInfoTexts[indexPath.row]
        cell.setData(number: number, text: text)
        return cell
    }
    
}

//MARK: userInfo collectionView delegateFlowLayout
extension HomeViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let noOfCellsInRow = viewModelUser.userInfoNumbers.count   //number of column you want
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let totalSpace = flowLayout.sectionInset.left
        + flowLayout.sectionInset.right
        + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))
        
        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))
        return CGSize(width: size, height: size)
    }
    
}


//MARK: userRepositry tableView delegate
extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let contributorVC = storyboard?.instantiateViewController(withIdentifier: "contributorVC") as? ContributorViewController{
            
            //MARK: passing userInput and repoName to contributorViewController
            contributorVC.user = userInput
            contributorVC.repoName = viewModelUser.repoData[indexPath.row].repoName
            
            //MARK: navigating to contributorViewController
            self.navigationController?.pushViewController(contributorVC, animated: true)
        }
    }
    
    
    //MARK: make segmentControll header of the tableview section
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .white
        let segmentedControl = UISegmentedControl(frame: CGRect(x: 10, y: 0, width: tableView.frame.width - 20, height: 30))
        segmentedControl.insertSegment(withTitle: "Overview", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Repositries", at: 1, animated: true)
        v.addSubview(segmentedControl)
        return v
    }
    
}


//MARK: userRepositry tableView dataSource
extension HomeViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelUser.repoData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath as IndexPath) as! repoTableViewCell
        let repoData = viewModelUser.repoData[indexPath.row]
        cell.setData(repoData: repoData)
        
        return cell
    }
}


