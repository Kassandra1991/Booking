//
//  Date + Extension.swift
//  Booking
//
//  Created by Aleksandra Asichka on 19/02/2025.
//

import Foundation

extension Date {
    
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    var isTheSameHour: Bool {
        Calendar.current.compare(self, to: Date(), toGranularity: .hour) == .orderedSame
    }
    
    var isPast: Bool {
        Calendar.current.compare(self, to: Date(), toGranularity: .hour) == .orderedAscending
    }
    
    var isFuture: Bool {
        Calendar.current.compare(self, to: Date(), toGranularity: .hour) == .orderedDescending
    }
    
    func format(with format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    func fetchWeek(_ date: Date = Date()) -> [WeekDay] {
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: date)
        var components = DateComponents()
        components.weekOfYear = 1
        var weekDays: [WeekDay] = []
        let weekForDate = calendar.dateInterval(of: .weekOfMonth, for: startOfDate)
        
        guard let startOfWeek = weekForDate?.start else { return weekDays }
        
        (0..<7).forEach { index in
            if let weekDate = calendar.date(byAdding: .day, value: index, to: startOfWeek) {
                weekDays.append(WeekDay(date: weekDate))
            }
        }
        return weekDays
    }
    
    func createNextWeek() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: self)
        guard let nextDate = calendar.date(byAdding: .day, value: 1, to: startOfDate) else { return [] }
        
        return fetchWeek(nextDate)
    }
    
    func createPreviousWeek() -> [WeekDay] {
        let calendar = Calendar.current
        let startOfDate = calendar.startOfDay(for: self)
        guard let previousDate = calendar.date(byAdding: .day, value: -1, to: startOfDate) else { return [] }
        
        return fetchWeek(previousDate)
    }
    
    struct WeekDay: Identifiable {
        var id: UUID = UUID()
        var date: Date
    }
}
