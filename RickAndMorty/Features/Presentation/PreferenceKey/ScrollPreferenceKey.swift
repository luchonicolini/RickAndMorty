//
//  ScrollPreferenceKey.swift
//  RickAndMorty
//
//  Created by Luciano Nicolini on 30/05/2024.
//

import Foundation
import SwiftUI

struct ScrollPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
