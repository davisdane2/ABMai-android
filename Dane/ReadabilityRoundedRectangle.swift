//
//  ReadabilityRoundedRectangle.swift
//  Dane
//
//  Created by Dane Davis on 10/12/25.
//  A view that adds a gradient over an image to aid legibility for text overlay.
//  Based on Apple's Landmarks design pattern.

import SwiftUI

/// A view that adds a gradient over an image to improve legibility for a text overlay.
struct ReadabilityRoundedRectangle: View {
    var body: some View {
        RoundedRectangle(cornerRadius: Constants.cornerRadius)
            .foregroundStyle(.clear)
            .background(
                LinearGradient(
                    colors: [.black.opacity(0.8), .clear],
                    startPoint: .bottom,
                    endPoint: .center
                )
            )
            .clipped()
    }
}
