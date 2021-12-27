//
//  File.swift
//  
//
//  Created by Joseph Wardell on 12/26/21.
//

import SwiftUI

@available(macOS 12, iOS 15, watchOS 8, tvOS 15, *)
internal extension Color {

    static var dateListBackground: Color {
#if os(macOS)
        Color(nsColor: .controlBackgroundColor).opacity(0.01)
#else
        Color(uiColor: .systemBackground).opacity(0.01)
#endif
    }
    
    static var foregroundContent: Color {
#if os(macOS)
        Color(nsColor: .labelColor)
#else
        Color.primary
#endif
    }
    
    static var foregroundAccent: Color {
#if os(macOS)
        Color(nsColor: .controlBackgroundColor)
#else
        Color(uiColor: .systemBackground)
#endif
    }

}
