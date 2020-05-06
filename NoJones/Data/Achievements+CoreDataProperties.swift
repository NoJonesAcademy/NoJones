//
//  Achievements+CoreDataProperties.swift
//  NoJones
//
//  Created by Vinicius Mesquita on 05/05/20.
//  Copyright © 2020 NoJones. All rights reserved.
//
//

import Foundation
import CoreData


extension Achievements {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Achievements> {
        return NSFetchRequest<Achievements>(entityName: "Achievements")
    }

    @NSManaged public var dateAcomplished: Date?
    @NSManaged public var done: Bool
    @NSManaged public var image: String?

}
