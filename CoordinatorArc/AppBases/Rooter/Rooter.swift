//
//  Rooter.swift
//  CoordinatorArc
//
//  Created by Samet Çeviksever on 15.03.2018.
//  Copyright © 2018 Samet Çeviksever. All rights reserved.
//

import UIKit

final class Rooter{
    fileprivate let rootController:UINavigationController
    fileprivate var handlers:[UIViewController:(()->())?]
    
    var viewControllers:[UIViewController]{ get{ return navigationController.viewControllers }}
    var navigationController:UINavigationController { get{ return rootController }}
    
    init(navigationController:UINavigationController) {
        rootController = navigationController
        
        handlers = [:]
    }
    
    func present(module:Rooter, animated:Bool = true, then:(()->())? = nil){
        rootController.present(module.rootController, animated: animated, completion: then)
    }
    
    func dismiss(animated:Bool = true, then:(()->())?){
        rootController.dismiss(animated: animated, completion: then)
    }
    
    func push(module:UIViewController?, animated:Bool = true, then:(()->())?){
        guard let controller = module else {return}
        rootController.pushViewController(controller, animated: animated)
        handlers[controller] = then
    }
    
    func popModule(animated:Bool = true){
        guard let controller = rootController.popViewController(animated: animated) else {return}
        runCompletion(to: controller)
    }
    
    func setViewControllersFromChildCoordinator(modules:[UIViewController]?,animated:Bool = true){
        if var controllers = modules, let last = rootController.topViewController{
            controllers.append(last)
            setViewControllers(modules: controllers, animated: false)
            popModule(animated: animated)
        } else {
            setViewControllers(modules: modules,animated: animated)
        }
    }
    
    func setViewController(module:UIViewController?,hideNavBar:Bool = false,animated:Bool = true){
        guard let vc = module else {return}
        setViewControllers(modules: [vc], hideNavBar: hideNavBar, animated: animated)
    }
    
    func setViewControllers(modules:[UIViewController]?,hideNavBar:Bool = false,animated:Bool = true){
        guard let controllers = modules else {return}
        rootController.setViewControllers(controllers, animated: animated)
        rootController.isNavigationBarHidden = hideNavBar
    }
    
    func popToRoot(animated:Bool = true){
        guard let controllers = rootController.popToRootViewController(animated: animated) else { return }
        controllers.forEach { (controller) in
            self.runCompletion(to: controller)
        }
    }
    
    fileprivate func runCompletion(to controller:UIViewController){
        guard let handler = handlers[controller] else {return}
        handler?()
        handlers.removeValue(forKey: controller)
    }
}

