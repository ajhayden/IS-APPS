//
//  DayOfWeekPicker.swift
//  MappedScriptures
//
//  Created by Student on 12/1/20.
//

import SwiftUI

struct DayOfWeekPicker: View {
    @Binding var selectedDays: [Bool]
    var body: some View {
        HStack(spacing: DayOfWeekPicker.buttonSpacing) {
            ForEach(DayOfWeekPicker.days.indices, id: \.self) { dayIndex in
                DayPicker(dayOfWeekText: DayOfWeekPicker.days[dayIndex],
                          selectionState: $selectedDays[dayIndex])
            }
        }
        .padding()
    }
    
    static let days = ["S", "M", "T", "W", "T", "F", "S"]
    static let buttonSpacing: CGFloat = 4
}

struct DayPicker: View {
    
    var dayOfWeekText: String
    @Binding var selectionState: Bool

    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(selectionState ? .blue : .clear)
                .frame(width: DayPicker.circleDiameter)
                .opacity(DayPicker.circleOpacity)
            Text(dayOfWeekText)
                .fontWeight(fontWeight())
                .foregroundColor(fontColor())
        }
        .onTapGesture {
            withAnimation {
                selectionState.toggle()
            }
        }
        
    }
    private func circleColor() -> Color {
        selectionState ? .blue : .clear
    }
    
    private func fontWeight() -> Font.Weight {
        selectionState ? .bold : .regular
    }
    
    private func fontColor() -> Color {
        selectionState ? .blue : .black
    }
    
    private static let circleDiameter: CGFloat = 40
    private static let circleOpacity = 0.3
}

struct DayOfWeekPicker_Previews: PreviewProvider {
    static var previews: some View {
        DayOfWeekPicker(selectedDays: .constant([false, true, false, true, false, true, false]))
    }
}
