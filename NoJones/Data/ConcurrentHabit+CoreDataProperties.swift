//
//  ConcurrentHabit+CoreDataProperties.swift
//  NoJones
//
//  Created by Vinicius Mesquita on 06/05/20.
//  Copyright © 2020 NoJones. All rights reserved.
//
//

import Foundation
import CoreData


extension ConcurrentHabit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ConcurrentHabit> {
        return NSFetchRequest<ConcurrentHabit>(entityName: "ConcurrentHabit")
    }

    @NSManaged public var category: String?
    @NSManaged public var name: String?
    @NSManaged public var habitOwner: Habit?

}
