//
//  CoreDao.swift
//  CoreDao
//
//  Created by Vinicius Mangueira on 01/07/19.
//  Copyright © 2019 Vinicius Mangueira. All rights reserved.
//
import CoreData

public class CoreDao<Element: NSManagedObject>: ConfigurableDao {
    
    public var context: NSManagedObjectContext
    private var containerName: String
    
    init(with containerName: String) {
        let coreStack = CoreStack(with: "NoJones")
        self.containerName = containerName
        context = coreStack.persistentContainer.viewContext
    }
    
    public func new() -> Element {
        return NSEntityDescription.insertNewObject(forEntityName: containerName, into: context) as! Element
    }
    
    public func insert(object: Element) {
        context.insert(object)
        save()
    }
    
    public func fetchAll() -> [Element] {
        let request = NSFetchRequest<Element>(entityName: containerName)
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
