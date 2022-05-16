//
//  PomodoroModel.swift
//  UI-563
//
//  Created by nyannyan0328 on 2022/05/16.
//

import SwiftUI

class PomodoroModel:NSObject, ObservableObject,UNUserNotificationCenterDelegate {
    @Published var stringValue : String = "00:00"
    @Published var progress : CGFloat = 1
    
    @Published var isStarted : Bool = false
    @Published var addNewTimer : Bool = false
    
    @Published var hour : Int = 0
    @Published var min : Int = 0
    @Published var sec : Int = 0
    
    @Published var totalSecond : Int = 0
    @Published var staticSeconds : Int = 0
    
    @Published var isFinished : Bool = false
    
    
    override init(){
        
        super.init()
        
        authorizedNotification()
    }
    
    func authorizedNotification(){
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.sound,.alert,.badge]) { _, _ in
            
            
        }
        
        UNUserNotificationCenter.current().delegate = self
        
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        completionHandler([.sound,.banner])
    }
    
    
    func addNotification(){
        
        let content = UNMutableNotificationContent()
        content.title =  "Pomodoro Timer"
        content.subtitle =  "😊"
        
        content.sound = UNNotificationSound.default
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(staticSeconds), repeats: false))
        
        UNUserNotificationCenter.current().add(request)
        
        
    }
    
    func startTimer(){
        
        
        withAnimation(.easeInOut){
            
            
            isStarted = true
        }
        
        stringValue = "\(hour == 0 ? "" : "\(hour):")\(min >= 10 ? "\(min)":"0\(min)"):\(sec >= 10 ? "\(sec)": "0\(sec)")"
        
        totalSecond = (hour * 3600) + (min * 60) + sec
        
        staticSeconds = totalSecond
        
        addNewTimer = false
        
        addNotification()
        
        
        
        
        
    }
    
    func stopTimer(){
        
        
        
        withAnimation{
            
            isStarted = false
            hour = 0
            min = 0
            sec = 0
            
            progress = 1
        }
        
        totalSecond = 0
        staticSeconds = 0
        stringValue = "00:00"
    }
    
    func updateTimer(){
        if totalSecond > 0 {
            
            totalSecond -= 1
        }
        
        progress = CGFloat(totalSecond) / CGFloat(staticSeconds)
        
        progress = (progress < 0 ? 0 : progress)
        
        hour = totalSecond / 3600
        
       
        
        min = (totalSecond % 60)
        
        sec = (totalSecond / 60) % 60
        
        stringValue = "\(hour == 0 ? "" : "\(hour):")\(min >= 10 ? "\(min)":"0\(min)") : \(sec >= 10 ? "\(sec)": "0\(sec)")"
        
        
        if hour == 0 && min == 0 && sec == 0{
            
            isStarted = false
            
            isFinished = true
        }
        
        
        
    }
}

