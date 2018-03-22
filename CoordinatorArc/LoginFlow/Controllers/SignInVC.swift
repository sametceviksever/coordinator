//
//  SignInVC.swift
//  CoordinatorArc
//
//  Created by Samet Çeviksever on 15.03.2018.
//  Copyright © 2018 Samet Çeviksever. All rights reserved.
//

import UIKit

class SignInVC: BaseVC {

    @IBOutlet weak var txtUserName:UITextField!
    @IBOutlet weak var txtPassword:UITextField!
    
    var createUserHandler:(()->())?
    var forgetPasswordHandler:(()->())?
    var loginSuccedHandler:(()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func navigateSignUp(){
        createUserHandler?()
    }
    
    @IBAction func navigateForgetPassword(){
        forgetPasswordHandler?()
    }
    
    @IBAction func login(){
        if let name = txtUserName.text,
            let password = txtPassword.text,
            name == "Samet",
            password == "1234"{
            
            User.shared.saveUser(name: name, pass: password)
            loginSuccedHandler?()
        }
    }
}

extension SignInVC:StoryboardInstantiate {
    static var storyboardType: StoryboardType {return .login}
}
