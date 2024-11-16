//
//  ContentView.swift
//  TestTimer
//
//  Created by Midhet Sulemani on 15/11/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: TimerViewModel
    
    var body: some View {
        VStack {
            TimerAnimation(viewModel: viewModel)
            HStack {
                Spacer()
                
                Button {
                    // "Start/Pause"
                    if viewModel.isPlaying {
                        viewModel.pauseTimer()
                    } else {
                        viewModel.startTimer()
                    }
                } label: {
                    let imageName = viewModel.isPlaying ? "pause.fill" : "play.fill"
                    Image(systemName: imageName)
                        .foregroundStyle(.blue)
                }
                
                Spacer()
                
                Button {
                    // "Stop"
                    viewModel.stopTimer()
                } label: {
                    Image(systemName: "stop.fill")
                        .foregroundStyle(.blue)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView(viewModel: TimerViewModel())
}
