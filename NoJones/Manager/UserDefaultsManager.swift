//
//  UserDefaultsManager.swift
//  NoJones
//
//  Created by Vinicius Mesquita on 02/05/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit

enum UserLoggedState {
    case firstLogin
    case alreadyLogged
}

enum UserDefaultsKey: String {
   case userName
   case bornDate
    
    // others atributes are added here
}

struct AppRouter {
    
    static func sendToOnboard(with window: UIWindow) {
        let storyboard = UIStoryboard(name: "OnBoarding", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as? OnBoardingViewController

        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
    static func sendToDashboard(with window: UIWindow) {
        let storyboard = UIStoryboard(name: "InitialScreen", bundle: .main)
        let viewController = storyboard.instantiateInitialViewController() as? InitialScreenViewController
        window.rootViewController = viewController
        window.makeKeyAndVisible()
    }
    
}

struct UserDefaultsManager {
    
    
    static func verifyState(completion: (UserLoggedState) -> ()) {
        
        let flag = UserDefaults.standard
        
        if UserDefaults.standard.bool(forKey: "bool") != true {
            
            flag.set(true, forKey: "bool")
            completion(.firstLogin)
            
        } else if flag.string(forKey: "userName") == nil {
            completion(.alreadyLogged)
        }
    }
    
    static func setUser(name: String, bornDate: Date) {
         UserDefaults.standard.set(name, forKey: UserDefaultsKey.userName.rawValue)
        UserDefaults.standard.set(bornDate, forKey: UserDefaultsKey.bornDate.rawValue)
     }
}
