//
//  User.swift
//  CoordinatorArc
//
//  Created by Samet Çeviksever on 16.03.2018.
//  Copyright © 2018 Samet Çeviksever. All rights reserved.
//

import Foundation

class User {
    static var shared:User = User()
    
    static var userNameDefaultKey = "userName"
    static var passwordDefaultKey = "password"
    
    fileprivate var userName:String?{
        didSet{
            UserDefaults.standard.set(userName, forKey: User.userNameDefaultKey)
        }
    }
    var password:String?{
        didSet{
            UserDefaults.standard.set(userName, forKey: User.passwordDefaultKey)
        }
    }
    
    static func isUserLoggedIn() -> Bool{
        if let name = shared.userName,
            let pass = shared.password{
            return name == "samet" && pass == "1234"
        }
        
        if let name = UserDefaults.standard.string(forKey: userNameDefaultKey),
            let pass = UserDefaults.standard.string(forKey: passwordDefaultKey){
            return name == "samet" && pass == "1234"
        }
        
        return false
    }
    
    func saveUser(name:String,pass:String){
        userName = name
        password = pass
    }
}
