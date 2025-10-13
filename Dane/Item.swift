//
//  Item.swift
//  Dane
//
//  Created by Dane Davis on 10/10/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
