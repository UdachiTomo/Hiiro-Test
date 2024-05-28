//
//  Hiiro_TestApp.swift
//  Hiiro Test
//
//  Created by udachi_tomo on 28.05.2024.
//

import SwiftUI

@main
struct Hiiro_TestApp: App {
    
    @StateObject var viewModel = CalendarViewModel()
    
    var body: some Scene {
        WindowGroup {
            CalendarView()
                .environmentObject(viewModel)
        }
    }
}
