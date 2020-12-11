//
//  DatePickerDemoView.swift
//  MappedScriptures
//
//  Created by Student on 12/1/20.
//

import SwiftUI

struct DatePickerDemoView: View {
    
    @State private var notificationsAllowed = false
    @State private var selectedDate = Date()
    @State private var selectedDays = [false, false, true, false, true, false, false]
    
    var body: some View {
        Form {
            DayOfWeekPicker(selectedDays: $selectedDays)
            DatePicker("Workout at", selection: $selectedDate,
                       displayedComponents: [.hourAndMinute] )
                Text("Selected date: \(selectedDate)")
            Button("Update Nofitication Schedule") {
                let center = UNUserNotificationCenter.current()
                
                center.removeAllPendingNotificationRequests()
                
                if notificationsAllowed {
                    selectedDays.indices.forEach { dayIndex in
                        let content = UNMutableNotificationContent()
                        content.title = "Time for your workout"
                        content.subtitle = "Remember your goal! No pain, no gain."
                        content.sound = UNNotificationSound.default
                        
                        var date = DateComponents()
                        let calendar = Calendar.current
                        
                        date.hour = calendar.component(.hour, from: selectedDate)
                        date.minute = calendar.component(.minute, from: selectedDate)
                        date.weekday = dayIndex + 1
                        
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(5), repeats: true)
                        
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        UNUserNotificationCenter.current().add(request)
                    }
                    
                    
                    
                }
            }
        }
        .onAppear() {
            UNUserNotificationCenter.current().requestAuthorization(options:
                [.alert, .sound, .provisional]) { success, error in
                if success {
                    notificationsAllowed = true
                } else if let error = error {
                    print(error.localizedDescription)
                }
                
            }
        }
    }
}

struct DatePickerDemoView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerDemoView()
    }
}
