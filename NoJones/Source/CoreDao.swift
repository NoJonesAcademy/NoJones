//
//  CoreDao.swift
//  CoreDao
//
//  Created by Vinicius Mangueira on 01/07/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//
import CoreData
import UIKit

public class CoreDao<Element: NSManagedObject>: ConfigurableDao {
    
    public var context: NSManagedObjectContext
    private var containerName: String
    
    init(with containerName: String) {
//        let coreStack = CoreStack(with: "NoJones")
        self.containerName = containerName
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
//        context = coreStack.persistentContainer.viewContext
    }
    
    public func new() -> Element {
        return NSEntityDescription.insertNewObject(forEntityName: Element.className, into: context) as! Element
    }
    
    
    
    public func insert(object: Element) {
        context.insert(object)
        save()
    }
    
    public func update(object: Element) {
//        context.delete()
    }
    
    public func fetchAll() -> [Element] {
        let request = NSFetchRequest<Element>(entityName: Element.className)
        let result = try! context.fetch(request)
        return result
    }
    
    public func delete(object: Element) {
        context.delete(object)
        save()
    }
    
    public func save() {
        do {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
}
