//
//  TimerViewModel.swift
//  TestTimer
//
//  Created by Midhet Sulemani on 16/11/24.
//

import Foundation

public final class TimerViewModel: ObservableObject {
    @Published var isPlaying: Bool = false
    @Published var fillValue: CGFloat = 1
    @Published var timerValue: String = "60.000"
    
    var timer: Timer?
    var secondCount: Int = 60000
    
    func startTimer() {
        isPlaying = true
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1/1000,
                                         target: self,
                                         selector: #selector(updateFillValue),
                                         userInfo: nil,
                                         repeats: true)
        }
        
        timer?.fire()
    }
    
    func pauseTimer() {
        isPlaying = false
        timer?.invalidate()
        timer = nil
    }
    
    func stopTimer() {
        pauseTimer()
        secondCount = 60000
        timerValue = "60.000"
        fillValue = 1
    }
    
    @objc func updateFillValue() {
        if secondCount <= 0 {
            stopTimer()
            return
        }
        secondCount -= 1
        fillValue = CGFloat((Double(secondCount)/60000))
        print("FILL VALUE", secondCount, Double(Double(secondCount)/60000), fillValue)
        timerValue = formatMmSsMl(counter: Double(60000 - secondCount))
    }
    
    func formatMmSsMl(counter: Double) -> String {
        let seconds = 59 - Int(counter/1000)
        let milliseconds = 1000 - Int(counter.truncatingRemainder(dividingBy: 1000))
        return String(format: "%02d.%02d", seconds, milliseconds)
    }
}
