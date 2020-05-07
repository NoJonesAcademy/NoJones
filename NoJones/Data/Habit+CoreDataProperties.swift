//
//  Habit+CoreDataProperties.swift
//  NoJones
//
//  Created by Vinicius Mesquita on 06/05/20.
//  Copyright © 2020 NoJones. All rights reserved.
//
//

import Foundation
import CoreData


extension Habit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Habit> {
        return NSFetchRequest<Habit>(entityName: "Habit")
    }

    @NSManaged public var finalFelling: String?
    @NSManaged public var initialFelling: String?
    @NSManaged public var name: String?
    @NSManaged public var concurrent: ConcurrentHabit?
    @NSManaged public var dates: DateHabit?
    @NSManaged public var userOwner: User?

}
