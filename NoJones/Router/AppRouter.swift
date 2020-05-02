//
//  AppRouter.swift
//  NoJones
//
//  Created by Vinicius Mesquita on 02/05/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

struct AppRouter {
    
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
        createRouteByState()
    }
    
    func createRouteByState() {
        
        UserDefaultsManager.verifyState { (state) in
                        
            switch state {
            case .firstLogin:
                sendToOnboard()
            case .alreadyLogged:
                sendToDashboard()
            }
            
        }
    }
    
    private func sendToOnboard() {
        let storyboard = UIStoryboard(name: "OnBoarding", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as? OnBoardingViewController

        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
    
    private func sendToDashboard() {
        let storyboard = UIStoryboard(name: "InitialScreen", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as? InitialScreenViewController
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }

    
    
}
