//
//  User+CoreDataProperties.swift
//  NoJones
//
//  Created by Vinicius Mesquita on 05/05/20.
//  Copyright © 2020 NoJones. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var age: Int32
    @NSManaged public var profileImage: Data?
    @NSManaged public var name: String?
    @NSManaged public var achievements: Achievements?
    @NSManaged public var habit: Habit?

}
