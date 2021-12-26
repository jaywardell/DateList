//
//  Dates.swift
//  LazyVStackDateToy
//
//  Created by Joseph Wardell on 12/26/21.
//

import Foundation

/// A RandomAccessCollection that provides a collection of dates indexed from a start date to and optional end date, with each date representing one day.
@available(macOS 12, iOS 15, watchOS 8, tvOS 15, *)
final class Dates: RandomAccessCollection, BidirectionalCollection {
    
    var startIndex: Int { 0 }
    let endIndex: Int
    private let startDate: Date
    
    /// created a Dates object to cover the days in the range of dates passed in
    /// - Parameters:
    ///   - startDate: the first date to be returned (at index 0)
    ///   - endDate: the last date to be presented (or the system date at time of creation if no other date is given)
    init(startDate: Date, endDate: Date = Date.now) {

        // we provide the dates in reverse order, so startDate goes to endIndex, and vice-versa
        let startComponenets = Calendar.current.dateComponents([.day], from: startDate, to: endDate)
        endIndex = startComponenets.day! + 1

        self.startDate = startDate
    }
        
    subscript(index: Int) -> Date {
        Calendar.current.date(byAdding: .day, value: index, to: startDate)!
    }
}
