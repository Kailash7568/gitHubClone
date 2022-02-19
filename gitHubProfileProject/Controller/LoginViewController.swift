//
//  LoginViewController.swift
//  gitHubProfileProject
//
//  Created by Kailash Jangir on 15/02/22.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: outlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: round edges of button
        Utilities.roundButton(button: loginButton)
        userNameTextField.delegate = self
        
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        let homeVC : HomeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeVC") as! HomeViewController
        homeVC.userInput = userNameTextField.text!
        userNameTextField.endEditing(true)
        self.navigationController?.pushViewController(homeVC, animated: true)
        
        
    }
    
}
