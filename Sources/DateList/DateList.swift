//
//  DateList.swift
//  LazyVStackDateToy
//
//  Created by Joseph Wardell on 12/26/21.
//

import SwiftUI

@available(macOS 15, iOS 15, watchOS 8, tvOS 15, *)
public struct DateList<DateContent: View, DataProvider: DateDataProvider> {
    
    let dates: Dates
            
    let dataProvider: DataProvider
    
    let alignment: HorizontalAlignment
        
    /// NOTE: only single.empty selection, no multiple selection, no required selection
    @Binding private var selectedDate: Date?
    private func isSelected(date: Date) -> Bool {
        guard let selectedDate = selectedDate else {
            return false
        }

        return Calendar.current.startOfDay(for: date) == Calendar.current.startOfDay(for: selectedDate)
    }

    let content: (Date, DataProvider.Output)->DateContent

    public init(startDate: Date,
         endDate: Date = Date.now,
         dataProvider: DataProvider,
         alignment: HorizontalAlignment = .leading,
         selectedDate: Binding<Date?> = .constant(nil),
         content: @escaping (Date, DataProvider.Output)->DateContent) {
        
        self.dates = Dates(startDate: startDate, endDate: endDate)
        self.dataProvider = dataProvider
        self.alignment = alignment
        self.content = content
        
        self._selectedDate = selectedDate
    }
}

// MARK: - DateList where DataProvider == EmptyDateDataProvider

@available(macOS 15, iOS 15, watchOS 8, tvOS 15, *)
public extension DateList where DataProvider == EmptyDateDataProvider {
    init(startDate: Date,
         endDate: Date = Date.now,
         alignment: HorizontalAlignment = .leading,
         selectedDate: Binding<Date?> = .constant(nil),
         content: @escaping (Date, DataProvider.Output)->DateContent) {
        self.init(startDate: startDate, endDate: endDate, dataProvider: EmptyDateDataProvider(), alignment: alignment, selectedDate: selectedDate, content: content)
    }
}

@available(macOS 15, iOS 15, watchOS 8, tvOS 15, *)
public extension DateList where DataProvider == EmptyDateDataProvider, DateContent == Text {
    init(startDate: Date,
         endDate: Date = Date.now,
         alignment: HorizontalAlignment = .leading,
         selectedDate: Binding<Date?> = .constant(nil)) {
        self.init(startDate: startDate, endDate: endDate, dataProvider: EmptyDateDataProvider(), alignment: alignment, selectedDate: selectedDate, content: Self.text(for:unused:))
    }
    
    private static func text(for date: Date, unused: Void) -> Text {
        Text(date, style: .date)
    }
}

// MARK: - DateList: View

@available(macOS 15, iOS 15, watchOS 8, tvOS 15, *)
extension DateList: View {

    public var body: some View {
        ScrollView {
            LazyVStack(alignment: alignment) {
                ForEach(dates.reversed(), id: \.self) { date in
                    HStack {
                        if alignment != .leading {
                            Spacer()
                        }
                        content(date, dataProvider.data(for: date))
                        
                        if alignment != .trailing {
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(isSelected(date: date) ? Color.accentColor : Color.dateListBackground)
                    .onTapGesture {
                        selectedDate = (selectedDate == date) ? nil : date
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}
