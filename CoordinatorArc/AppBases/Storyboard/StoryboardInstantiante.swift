//
//  StoryboardInstantiante.swift
//  CoordinatorArc
//
//  Created by Samet Çeviksever on 15.03.2018.
//  Copyright © 2018 Samet Çeviksever. All rights reserved.
//

import UIKit

enum StoryboardType:String{
    case main = "Main"
    case login = "Login"
}

protocol StoryboardInstantiate {
    static var storyboardType:StoryboardType{get}
    static var bundle:Bundle?{get}
    static var controllerIdentifier:String?{get}
}

extension StoryboardInstantiate{
    static var bundle:Bundle? {return nil}
    static var controllerIdentifier:String? {return String(describing:self)}
    
    static func instantiate() -> Self{
        let storyboard = UIStoryboard(name: storyboardType.rawValue, bundle: bundle)
        
        if let id = controllerIdentifier{
            return storyboard.instantiateViewController(withIdentifier: id) as! Self
        } else {
            return storyboard.instantiateInitialViewController() as! Self
        }
    }
}
