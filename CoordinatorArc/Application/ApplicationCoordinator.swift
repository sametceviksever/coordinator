//
//  ApplicationCoordinator.swift
//  CoordinatorArc
//
//  Created by Samet Çeviksever on 16.03.2018.
//  Copyright © 2018 Samet Çeviksever. All rights reserved.
//

import UIKit

final class ApplicationCoordinator:Coordinator{
    
    static var onboardWasShown:Bool = true
    static var isAutorized:Bool = {User.isUserLoggedIn()}()
    
    enum LaunchInstructor{
        case onboard
        case login
        case main
        
        static func configure() -> LaunchInstructor{
            switch (ApplicationCoordinator.onboardWasShown,ApplicationCoordinator.isAutorized) {
            case (false,true),(false,false):
                return .onboard
            case (true,false):
                return .login
            case (true,true):
                return .main
            }
        }
    }
    
    var rootController: Rooter
    var ownStateControllers: [UIViewController]
    var flowQuitHandler: (() -> ())?
    var childCoordinator: Coordinator?
    
    init(rooter: Rooter) {
        rootController = rooter
        ownStateControllers = [UIViewController]()
    }
    
    func start(userInfo: [AnyHashable : String]? = nil) {
        let launchConfigure = LaunchInstructor.configure()
        
        switch launchConfigure {
        case .onboard:
            break
        case .login:
            runLoginFlow()
        case .main:
            break
        }
    }
    
    fileprivate func runLoginFlow(){
        let coordinator = LoginCoordinator(rooter: rootController)
        if addChildCoordinatorIfPossible(child: coordinator){
            coordinator.start(userInfo: nil)
            coordinator.flowQuitHandler = {[weak self] in
                self?.removeChildCoordinator()
                self?.start()
            }
        }
    }
    
    fileprivate func runMainFlow(userInfo: [AnyHashable : String]? = nil){
//        let coordinator = 
    }
}
