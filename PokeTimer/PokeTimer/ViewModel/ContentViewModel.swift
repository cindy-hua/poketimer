//
//  ContentViewModel.swift
//  PokeTimer
//
//  Created by HUA Cindy on 25/02/2025.
//

import Foundation

class ContentViewModel: ObservableObject {
    // Timer-related states.
    @Published var selectedDuration: Int = 5
    
    // Duration options from 5 to 120 minutes (in steps of 5).
    let durationOptions = Array(stride(from: 5, through: 120, by: 5))
}
