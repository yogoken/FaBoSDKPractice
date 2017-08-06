//
//  ViewController.swift
//  FaBoSDKPractice
//
//  Created by 余語憲太 on 2017/08/06.
//  Copyright © 2017年 yogoken. All rights reserved.
//

import UIKit

import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class ViewController: UIViewController, FBSDKLoginButtonDelegate {
    /**
     Sent to the delegate when the button was used to login.
     - Parameter loginButton: the sender
     - Parameter result: The results of the login
     - Parameter error: The error (if any) from the login
     */
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        guard error == nil else {
            print("Error: \(error)")
            return
        }
        
        if result.isCancelled {
            print("Cancelled");
            
        } else {
            print("Logged in");
            getUserData()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logout");
    }
    
    
    var customButton:UIButton!
    var isLogin = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "user_birthday", "email"]
        loginButton.center = view.center
        loginButton.delegate = self
        view.addSubview(loginButton)
        
        customButton = UIButton(type: .system)
        customButton.setTitle("My Login Button", for: .normal)
        customButton.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        customButton.frame = CGRect(x: 0, y: 0, width: 180, height: 80)
        customButton.center = view.center
        customButton.center.y += 40
        view.addSubview(customButton)
    }
    
    func loginButtonClicked(){
        let loginManager = FBSDKLoginManager()
        if !isLogin {
            loginManager.logIn(withReadPermissions: ["public_profile", "user_birthday", "email"], from: self) { (result, error) in
                guard error == nil else {
                    print("Process error");
                    return
                }
                if (result?.isCancelled)! {
                    print("Cancelled");
                } else {
                    print("Logged in");
                    self.getUserData()
                    self.customButton.setTitle("Logout", for: .normal)
                }
            }
        } else {
            loginManager.logOut()
            customButton.setTitle("My Login Button", for: .normal)
        }
        self.isLogin = !self.isLogin
    }
    
    func getUserData(){
        let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id,name,first_name,middle_name,last_name,birthday,email"])
        graphRequest?.start { (connection, result, error) in
            guard error == nil && result != nil else{
                print("Error: \(error)")
                return
            }
            
            print("User: \(result)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

