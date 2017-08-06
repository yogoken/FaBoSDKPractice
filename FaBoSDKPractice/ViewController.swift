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

var customButton:UIButton!
var isLogin = false

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBSDKLoginButton()
        loginButton.center = view.center
        loginButton.readPermissions = ["public_profile"]
        view.addSubview(loginButton)
        
        customButton = UIButton(type: .system)
        customButton.setTitle("My Login Button", forState: .normal)
        customButton.addTarget(self, action: #selector(self.loginButtonClicked), forControlEvents: .touchUpInside)
        customButton.frame = CGRectMake(0, 0, 180, 80)
        customButton.center = view.center
        customButton.center.y += 40
        view.addSubview(customButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

