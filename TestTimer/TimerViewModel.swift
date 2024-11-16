//
//  TimerViewModel.swift
//  TestTimer
//
//  Created by Midhet Sulemani on 16/11/24.
//

import Foundation
import UserNotifications
import Combine

public final class TimerViewModel: NSObject, ObservableObject {
    @Published var isPlaying: Bool = false
    @Published var fillValue: CGFloat = 1
    @Published var timerValue: String = "60.000"
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    var cancellables: Set<AnyCancellable> = .init()
    var timer: Timer?
    var secondCount: Int = 60000
    var savedDate: Date?
    var calculateElapsedTime: PassthroughSubject<Void, Never> = .init()
    
    override init() {
        super.init()
        
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error {
                print(error.localizedDescription)
            }
        }
        
        notificationCenter.delegate = self
        
        bind()
    }
    
    private func bind() {
        calculateElapsedTime
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self, let savedDate else { return }
                
                let calendar = Calendar.current
                let difference = calendar.dateComponents([.second], from: savedDate, to: Date())
                let seconds = difference.second!
                let milliSeconds = seconds * 1000
                
                if milliSeconds < 60000 {
                    secondCount -= milliSeconds
                } else {
                    stopTimer()
                }
            }
            .store(in: &cancellables)
    }
    
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
        showNotification()
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
    
    func showNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Feed the cat"
        content.subtitle = "It looks hungry"
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        notificationCenter.add(request) { error in
            if let error {
                print("NOTIFICATION ERROR", error.localizedDescription)
            }
        }
    }
    
    @objc func updateFillValue() {
        if secondCount <= 0 {
            stopTimer()
            return
        }
        secondCount -= 1
        fillValue = CGFloat((Double(secondCount)/60000))
        timerValue = formatMmSsMl(counter: Double(60000 - secondCount))
    }
    
    func formatMmSsMl(counter: Double) -> String {
        let seconds = 59 - Int(counter/1000)
        let milliseconds = 1000 - Int(counter.truncatingRemainder(dividingBy: 1000))
        return String(format: "%02d.%02d", seconds, milliseconds)
    }
    
    deinit {
        timer?.invalidate()
        cancellables.removeAll()
    }
}

extension TimerViewModel: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }
}
