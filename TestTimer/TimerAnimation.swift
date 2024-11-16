//
//  TimerAnimation.swift
//  TestTimer
//
//  Created by Midhet Sulemani on 15/11/24.
//

import SwiftUI

struct TimerAnimation: View {
    @ObservedObject var viewModel: TimerViewModel
    
    var body: some View {
        ZStack {
            // Track circle
            Circle()
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 30))
            // Animation circle
            Circle()
                .trim(from: 0, to: viewModel.dataModel.fillValue)
                .stroke(Color.yellow, style: StrokeStyle(lineWidth: 30))
                .rotationEffect(.init(degrees: -90))
                .animation(.default)
            
            Text(viewModel.dataModel.timerValue)
                .font(.system(size: 52))
        }
        .padding(50)
    }
}

#Preview {
    TimerAnimation(viewModel: TimerViewModel())
}
