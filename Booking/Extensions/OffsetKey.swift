//
//  OffsetKey.swift
//  Booking
//
//  Created by Aleksandra Asichka on 19/02/2025.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: Int { 0 }
    static func reduce(value: inout Int, nextValue: () -> Int) {
        value += nextValue()
    }
}
