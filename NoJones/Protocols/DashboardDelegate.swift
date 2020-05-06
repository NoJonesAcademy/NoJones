//
//  DashboardDelegate.swift
//  NoJones
//
//  Created by Vinicius Mesquita on 04/05/20.
//  Copyright © 2020 NoJones. All rights reserved.
//

import Foundation

protocol DashboardDelegate: class {
    func sendHabitDetails(habits: [Addiction])
}
