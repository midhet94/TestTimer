//
//  TimerAnimation.swift
//  TestTimer
//
//  Created by Midhet Sulemani on 15/11/24.
//

import SwiftUI

struct TimerAnimation: View {
    @State var fill: CGFloat = 0.1
    
    var body: some View {
        ZStack {
            // Track circle
            Circle()
                .stroke(Color.blue, style: StrokeStyle(lineWidth: 30))
            // Animation circle
            Circle()
                .trim(from: 0, to: self.fill)
                .stroke(Color.yellow, style: StrokeStyle(lineWidth: 30))
                .rotationEffect(.init(degrees: -90))
                .animation(.default)
            
            Text("\(self.fill)")
                .font(.system(size: 52))
        }
        .padding(50)
    }
}

#Preview {
    TimerAnimation()
}
