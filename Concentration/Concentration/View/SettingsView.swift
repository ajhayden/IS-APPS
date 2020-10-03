//
//  GameSettingsView.swift
//  Concentration
//
//  Created by Student on 10/2/20.
//

import SwiftUI

import SwiftUI

struct SettingsView: View {
    @State var soundOn: Bool = true
    var body: some View {
        VStack {
            NavigationView {
                    Form {
                        Section(header: Text("Settings")) {
                            Toggle(isOn: $soundOn) {
                                Text("Sound Effects")
                            }
                            Button("Save") {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    print("Saved")
                                }
                            }
                            .foregroundColor(Color.white)
                            .frame(width: 90, height: 40)
                            .background(Color.green)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .font(.system(size: 19))
                            .padding(10)
                            .padding(.trailing, 100)
                        }
                    }
                    .navigationBarTitle("Settings")
                }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
