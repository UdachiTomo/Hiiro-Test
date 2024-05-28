//
//  Calendar.swift
//  Hiiro Test
//
//  Created by udachi_tomo on 28.05.2024.
//

import SwiftUI

struct Actitvity: Identifiable {
    var id = UUID().uuidString
    var image: ImageResource
    var type: String
    var activityTime: String
    var activityDescription: String
    var calendarDate: Date
}

