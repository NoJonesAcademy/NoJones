//
//  Date+Age.swift
//  NoJones
//
//  Created by Vinicius Mesquita on 07/05/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import Foundation

extension Date {
    
    var age: Int { Calendar.current.dateComponents([.year], from: self, to: Date()).year! }
    
}
