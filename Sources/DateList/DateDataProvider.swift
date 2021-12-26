//
//  DateDataProvider.swift
//  LazyVStackDateToy
//
//  Created by Joseph Wardell on 12/25/21.
//

import Foundation

public protocol DateDataProvider: ObservableObject {
    associatedtype Output
    
    func data(for date: Date) -> Output
}

public protocol DayDataProvider: DateDataProvider {
    var calendar: Calendar { get }
    func dataFor(day: Int, month: Int, year: Int) -> Output
}

public extension DayDataProvider {
    
    func data(for date: Date) -> Output {
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        guard let day = components.day,
              let month = components.month,
              let year = components.year
        else { fatalError() }
        
        return dataFor(day: day, month: month, year: year)
    }
}

public final class EmptyDateDataProvider: DateDataProvider {
    public func data(for date: Date) -> Void {}
}




public final class EveryOtherDay: DayDataProvider {
    public typealias Output = String?
    public var calendar: Calendar = .current
    
    public func dataFor(day: Int, month: Int, year: Int) -> String? {
        guard day % 4 == 0 else { return nil }
        
        return "\(year):\(month):\(day)"
    }
}

public final class EveryFourthDayCount: DayDataProvider {
    public typealias Output = Int
    public var calendar: Calendar = .current
    
    public func dataFor(day: Int, month: Int, year: Int) -> Int {
        
        return day % 4
    }
}

public final class RandomNumber: DayDataProvider {
    public typealias Output = Int?
    public var calendar: Calendar = .current
    
    public func dataFor(day: Int, month: Int, year: Int) -> Int? {
        guard Bool.random() else { return nil }
        return Int.random(in: 0...10)
    }
}
