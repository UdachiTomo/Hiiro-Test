//
//  Hiiro_TestTests.swift
//  Hiiro TestTests
//
//  Created by udachi_tomo on 28.05.2024.
//

import XCTest
@testable import Hiiro_Test
final class Hiiro_TestTests: XCTestCase {

        var calendarViewModel: CalendarViewModel?

        override func setUp() {
            calendarViewModel = CalendarViewModel()
        }

        func testFilteredActivitiesToday() {
            let today = Date()
            calendarViewModel?.currentDay = today
            calendarViewModel?.filtredActivitiesToday()

            XCTAssertNotNil(calendarViewModel?.filtredActivities)
        }

        func testExtractDate() {
            let date = Date()
            let formattedDate = calendarViewModel?.extractDate(date: date, format: "dd/MM/yyyy", with: false)
            XCTAssertEqual(formattedDate, "29/05/2024")
        }

        override func tearDown() {
            calendarViewModel = nil
        }

}
