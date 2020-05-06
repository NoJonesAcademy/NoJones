//
//  DateHabit+CoreDataProperties.swift
//  NoJones
//
//  Created by Vinicius Mesquita on 05/05/20.
//  Copyright © 2020 NoJones. All rights reserved.
//
//

import Foundation
import CoreData


extension DateHabit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DateHabit> {
        return NSFetchRequest<DateHabit>(entityName: "DateHabit")
    }

    @NSManaged public var data: Date?
    @NSManaged public var done: Bool

}
