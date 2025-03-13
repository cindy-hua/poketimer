//
//  FocusDurationPickerView.swift
//  PokeTimer
//
//  Created by HUA Cindy on 13/03/2025.
//

import SwiftUI

struct FocusDurationPickerView: View {
    @Binding var selectedDuration: Int
    let durationOptions: [Int]

    var body: some View {
        Picker("Focus Duration", selection: $selectedDuration) {
            ForEach(durationOptions, id: \.self) { minutes in
                Text("\(minutes) minutes").tag(minutes)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .frame(height: 100)
    }
}

#Preview {
    FocusDurationPickerView(selectedDuration: .constant(25), durationOptions: [10, 25, 50])
}
