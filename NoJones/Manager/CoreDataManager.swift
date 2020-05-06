//
//  CoreDataManager.swift
//  NoJones
//
//  Created by Vinicius Mesquita on 05/05/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import UIKit
import CoreData


struct CoreDataManager {
    
    var appDelegate: AppDelegate?
    private static var entity: NSManagedObject?
    private static var entities: [NSManagedObject] = []
    
    @available(iOS 13.0, *)
    static func saveUser(name: String, profileImage: Data) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // 1
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // 2
        let entity = NSEntityDescription.entity(forEntityName: "User",
                                                in: managedContext)!
        
        let object = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        object.setValue(name, forKeyPath: "name")
        object.setValue(profileImage, forKeyPath: "profileImage")
        // 4

        
        do {
            try managedContext.save()
            self.entity = object
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    @available(iOS 13.0, *)
    static func fetchUser() -> User? {
        
        //1
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
        
        //3
        do {
            entities = try managedContext.fetch(fetchRequest)
            let users = entities as? [User]
            users?.forEach({ user in
                print(user.profileImage ?? "n tem")
            })
            return users?.last
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return nil
    }
}
