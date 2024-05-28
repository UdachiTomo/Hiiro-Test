//
//  CalendarViewModel.swift
//  Hiiro Test
//
//  Created by udachi_tomo on 28.05.2024.
//

import SwiftUI
final class CalendarViewModel: ObservableObject {
    
    @Published var mockActivities: [Actitvity] = [
        Actitvity(image: ImageResource.intervals ,type: "Intervals", activityTime: "8km", activityDescription: "200/400 rest", calendarDate: .init(timeIntervalSince1970: 1716893060)),
        Actitvity(image: ImageResource.easyRun ,type: "Easy Run", activityTime: "10km", activityDescription: "HR zone 2", calendarDate: .init(timeIntervalSince1970: 1716893060)),
        Actitvity(image: ImageResource.tempoRun ,type: "Tempo Run", activityTime: "6km", activityDescription: "HR zone 3-4", calendarDate: .init(timeIntervalSince1970: 1716893060)),
        Actitvity(image: ImageResource.longRun ,type: "Longrun", activityTime: "17km", activityDescription: "65%", calendarDate: .init(timeIntervalSince1970: 1717065860)),
        Actitvity(image: ImageResource.strengthTraining ,type: "Strength training ", activityTime: "1 hour", activityDescription: "dumbells, djhahdjahdadad", calendarDate: .init(timeIntervalSince1970: 1717065860)),
        Actitvity(image: ImageResource.intervals ,type: "Intervals", activityTime: "8km", activityDescription: "200/400 rest", calendarDate: .init(timeIntervalSince1970: 1717065860)),
        Actitvity(image: ImageResource.easyRun ,type: "Easy Run", activityTime: "10km", activityDescription: "HR zone 2", calendarDate: .init(timeIntervalSince1970: 1717065860))
    ]
    
    @Published var currentWeek: [Date] = []
    
    @Published var currentDay: Date = Date()
    
    @Published var filtredActivities: [Actitvity]?
    
    init() {
        fetchThreeWeeks()
        filtredActivitiesToday()
    }
    
    private func fetchThreeWeeks() {
        let today = Date()
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        guard let firstWeekDay = week?.start else {
            return
        }
        
        (-1...20).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekday)
            }
        }
    }
    
    func filtredActivitiesToday() {
        DispatchQueue.global(qos: .userInteractive).async {
            let calendar = Calendar.current
            let filtred = self.mockActivities.filter {
                return calendar.isDate($0.calendarDate, inSameDayAs: self.currentDay)
            }
            DispatchQueue.main.async {
                withAnimation {
                    self.filtredActivities = filtred
                }
            }
        }
    }
    
    func extractDate(date: Date, format: String, with uppercased: Bool) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if uppercased {
            return formatter.string(from: date).uppercased()
        } else {
            return formatter.string(from: date)
        }
    }
    
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
    
    func isActivity(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
}
