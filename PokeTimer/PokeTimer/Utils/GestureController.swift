//
//  GestureController.swift
//  PokeTimer
//
//  Created by HUA Cindy on 14/03/2025.
//

import Foundation

enum GestureType {
    case none, rotating, swipingPokemon, holding
}

class GestureController: ObservableObject {
    @Published var activeGesture: GestureType = .none
}
