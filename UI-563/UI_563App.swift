//
//  UI_563App.swift
//  UI-563
//
//  Created by nyannyan0328 on 2022/05/16.
//

import SwiftUI

@main
struct UI_563App: App {
    @StateObject var model : PomodoroModel = .init()
    @Environment(\.scenePhase) var phase
    
    @State var lastActiveStamp : Date = Date()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
        .onChange(of: phase) { newValue in
            
            
            if model.isStarted{
                
                if newValue == .background{
                    
                    lastActiveStamp = Date()
                }
                
                if newValue == .active{
                    
                    
                    let currentTimeStampDiff = Date().timeIntervalSince(lastActiveStamp)
                    if model.totalSecond - Int(currentTimeStampDiff) <= 0{
                        
                        
                        
                        model.isStarted = false
                        model.totalSecond = 0
                        model.updateTimer()
                        
                    }
                    else{
                        
                        model.totalSecond -= Int(currentTimeStampDiff)
                    }
                }
            }
            
        }
    }
}
