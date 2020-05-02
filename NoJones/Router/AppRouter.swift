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
    
    func createRouteByState(with window: UIWindow?) {
        
        UserDefaultsManager.verifyState { (state) in
            
            guard let window = window else { return }
            
            switch state {
            case .firstLogin:
                sendToOnboard(with: window)
            case .alreadyLogged:
                sendToDashboard(with: window)
            }
            
        }
    }
    
    private func sendToOnboard(with window: UIWindow) {
        let storyboard = UIStoryboard(name: "OnBoarding", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as? OnBoardingViewController

        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    private func sendToDashboard(with window: UIWindow) {
        let storyboard = UIStoryboard(name: "InitialScreen", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as? InitialScreenViewController
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }

    
    
}
