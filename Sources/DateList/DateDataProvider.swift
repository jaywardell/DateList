//
//  DateDataProvider.swift
//  LazyVStackDateToy
//
//  Created by Joseph Wardell on 12/25/21.
//

import Foundation

protocol DateDataProvider: ObservableObject {
    associatedtype Output
    
    func data(for date: Date) -> Output
}

protocol DayDataProvider: DateDataProvider {
    var calendar: Calendar { get }
    func dataFor(day: Int, month: Int, year: Int, calendar: Calendar) -> Output
}

extension DayDataProvider {
        
    func data(for date: Date) -> Output {
//        print(#function, date)
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        guard let day = components.day,
              let month = components.month,
              let year = components.year
        else { fatalError() }
        
        return dataFor(day: day, month: month, year: year, calendar: calendar)
    }
}

final class EmptyDateDataProvider: DateDataProvider {
    func data(for date: Date) -> Void {}
}




final class EveryOtherDay: DayDataProvider {
    typealias Output = String?
    var calendar: Calendar = .current

    func dataFor(day: Int, month: Int, year: Int, calendar: Calendar) -> String? {
        guard day % 4 == 0 else { return nil }

        return "\(year):\(month):\(day)"
    }
}

final class EveryFourthDayCount: DayDataProvider {
    typealias Output = Int
    var calendar: Calendar = .current

    func dataFor(day: Int, month: Int, year: Int, calendar: Calendar) -> Int {

        return day % 4
    }
}

final class RandomNumber: DayDataProvider {
    typealias Output = Int?
    var calendar: Calendar = .current

    func dataFor(day: Int, month: Int, year: Int, calendar: Calendar) -> Int? {
        guard Bool.random() else { return nil }
        return Int.random(in: 0...10)
    }
}
