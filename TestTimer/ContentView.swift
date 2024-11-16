//
//  ContentView.swift
//  TestTimer
//
//  Created by Midhet Sulemani on 15/11/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var viewModel: TimerViewModel
    
    
    
    var body: some View {
        VStack {
            TimerAnimation(viewModel: viewModel)
            HStack {
                Spacer()
                
                Button {
                    // Start/Pause
                    if viewModel.dataModel.isPlaying {
                        viewModel.pauseTimer()
                    } else {
                        viewModel.startTimer()
                    }
                } label: {
                    let imageName = viewModel.dataModel.isPlaying ? "pause.fill" : "play.fill"
                    Image(systemName: imageName)
                        .foregroundStyle(.blue)
                }
                
                Spacer()
                
                Button {
                    // Stop
                    viewModel.stopTimer()
                } label: {
                    Image(systemName: "stop.fill")
                        .foregroundStyle(.blue)
                }
                
                Spacer()
            }
            .padding()
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            switch newPhase {
            case .active:
                viewModel.calculateElapsedTime.send()
            case .background:
                viewModel.savedDate = Date()
            default:
                break
            }
        }
    }
}

#Preview {
    ContentView(viewModel: TimerViewModel())
}
