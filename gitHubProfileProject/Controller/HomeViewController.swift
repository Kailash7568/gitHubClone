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
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var lblBio: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var headerSegmentControl: UISegmentedControl!
    
    var userInput: String = ""
    let margin: CGFloat = 10
    
    
    //MARK: UserViewModel object
    var viewModelUser = GitUserProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(viewModelUser.numbers.isEmpty){
            collectionViewHeightConstraints.constant = 0
        }
        viewModelUser.delegate = self
        viewModelUser.getUserData(user: userInput)
        viewModelUser.getRepoData(user: userInput)
        
        
        Utilities.roundImage(imageView: userImageView)
        Utilities.roundButton(button: followButton)
        
        
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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        //MARK: tableView Code
        
    }
    
    
    //MARK: Conforming protocol-delegate method didFinishFetchingUserData()
    func didFinishFetchingUserData(){
        DispatchQueue.main.async {
            guard let userName = self.viewModelUser.userData?.userName else { return }
            self.userName.text = "@" + userName
            self.name.text = self.viewModelUser.userData?.name
            self.lblBio.text = self.viewModelUser.userData?.bio
            guard let userImage = self.viewModelUser.userData?.userImageUrl else { return }
            self.userImageView.sd_setImage(with: URL(string: userImage), completed: nil)
            if(!self.viewModelUser.numbers.isEmpty){
                self.collectionViewHeightConstraints.constant = 70
                self.collectionView.reloadData()
            }
        }
    }
    
    //MARK: Conforming protocol-delegate method didFinishFetchingRepoData()
    func didFinishFetchingRepoData(){
        DispatchQueue.main.async {
            if(!self.viewModelUser.repoData.isEmpty){
                self.tableView.reloadData()
            }
        }
    }
    
}


//MARK: collectionView Code

//MARK: collectionView dataSource
extension HomeViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModelUser.numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath as IndexPath) as! userCollectionViewCell
        
        let number = viewModelUser.numbers[indexPath.row]
        let text = viewModelUser.texts[indexPath.row]
        cell.setData(number: number, text: text)
        return cell
    }
    
}

//MARK: collectionView delegateFlowLayout
extension HomeViewController : UICollectionViewDelegateFlowLayout{
    
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
extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let contributorVC = storyboard?.instantiateViewController(withIdentifier: "contributorVC") as? contributorViewController{
            
            //MARK: passing userInput and repoName to contributorViewController
            contributorVC.user = userInput
            contributorVC.repoName = viewModelUser.repoData[indexPath.row].repoName!
            
            //MARK: navigating to contributorViewController
            self.navigationController?.pushViewController(contributorVC, animated: true)
        }
    }
    
    
    //
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = .white
        let segmentedControl = UISegmentedControl(frame: CGRect(x: 10, y: 0, width: tableView.frame.width - 20, height: 30))
        segmentedControl.insertSegment(withTitle: "Overview", at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: "Repositries", at: 1, animated: true)
        v.addSubview(segmentedControl)
        return v
    }
    //
}


//MARK: tableView dataSource
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
//MARK: tableView Code
