//
//  Coordinator.swift
//  CoordinatorArc
//
//  Created by Samet Çeviksever on 15.03.2018.
//  Copyright © 2018 Samet Çeviksever. All rights reserved.
//

import UIKit

protocol Coordinator:class {
    var rootController:Rooter{get set}
    var ownStateControllers:[UIViewController] {get set}
    var flowQuitHandler:(()->())?{get set}
    var childCoordinator:Coordinator?{get set}
    
    init(rooter:Rooter)
    func start(userInfo:[AnyHashable:String]?)
    func addChildCoordinatorIfPossible(child:Coordinator,saveOwnState:Bool) -> Bool
    func removeChildCoordinator()
    func childCoordinatorDidQuit()
    func popController()
}

extension Coordinator{
    
    func addChildCoordinatorIfPossible(child:Coordinator,saveOwnState:Bool = true) -> Bool{
        if childCoordinator == nil {
            childCoordinator = child
            childCoordinator?.flowQuitHandler = childCoordinatorDidQuit
            if saveOwnState{
                ownStateControllers = rootController.viewControllers
            }
            return true
        } else {
            return false
        }
    }
    
    func removeChildCoordinator(){
        childCoordinator?.flowQuitHandler = nil
        childCoordinator = nil
    }
    
    func popController(){
        rootController.popModule()
    }
    
    func childCoordinatorDidQuit() {}
}
