//
//  ContentView.swift
//  TestTimer
//
//  Created by Midhet Sulemani on 15/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            TimerAnimation()
            HStack {
                Button("Start/Pause") {
                    
                }
                
                Button("Stop") {
                    
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
