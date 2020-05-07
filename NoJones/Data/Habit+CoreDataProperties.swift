//
//  Habit+CoreDataProperties.swift
//  NoJones
//
//  Created by Vinicius Mesquita on 07/05/20.
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
    @NSManaged public var dates: NSSet?
    @NSManaged public var userOwner: User?

}

// MARK: Generated accessors for dates
extension Habit {

    @objc(addDatesObject:)
    @NSManaged public func addToDates(_ value: DateHabit)

    @objc(removeDatesObject:)
    @NSManaged public func removeFromDates(_ value: DateHabit)

    @objc(addDates:)
    @NSManaged public func addToDates(_ values: NSSet)

    @objc(removeDates:)
    @NSManaged public func removeFromDates(_ values: NSSet)

}
