//
//  LoginCoordinator.swift
//  CoordinatorArc
//
//  Created by Samet Çeviksever on 15.03.2018.
//  Copyright © 2018 Samet Çeviksever. All rights reserved.
//

import UIKit

class LoginCoordinator: Coordinator {
    
    enum LoginPageType {
        case signIn
        case signUp
        case forgetPassword
    }
    
    var rootController: Rooter
    var ownStateControllers: [UIViewController]
    var flowQuitHandler: (() -> ())?
    var childCoordinator: Coordinator?
    
    required init(rooter: Rooter) {
        rootController = rooter
        ownStateControllers = [UIViewController]()
    }
    
    func start(userInfo: [AnyHashable : String]?) {
        if userInfo == nil{
            runSignIn()
        }
    }
    
    fileprivate func runSignIn(){
        let vc = SignInVC.instantiate()
        rootController.setViewController(module: vc)
    }
}
