//
//  Home.swift
//  UI-563
//
//  Created by nyannyan0328 on 2022/05/16.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var model : PomodoroModel
    var body: some View {
        VStack{
            
            Text("Pomodoro Timer")
                .font(.footnote.weight(.light))
            
            GeometryReader{proxy in
                
                VStack(spacing:15){
                    
                    ZStack{
                        
                        
                       Circle()
                            .fill(.white.opacity(0.03))
                            .padding(-40)
                        
                        Circle()
                            .trim(from: 0, to: model.progress)
                            .stroke(.white.opacity(0.03),lineWidth: 10)
                          
                        
                        Circle()
                            .stroke(Color("Purple"),lineWidth: 5)
                            .blur(radius: 15)
                            .padding(2)
                        
                        
                        Circle()
                            .fill(Color("BG"))
                        
                        Circle()
                            .trim(from: 0, to: model.progress)
                            .stroke(Color("Purple"),lineWidth: 10)
                        
                        GeometryReader{proxy in
                            
                            
                            let size = proxy.size
                            
                            Circle()
                                .fill(Color("Purple"))
                                .frame(width: 30, height: 30)
                                .overlay(content: {
                                    
                                    Circle()
                                        .fill(.white)
                                        .padding(5)
                                })
                                .frame(width: size.width, height: size.height)
                                .offset(x: size.height / 2)
                                .rotationEffect(.init(degrees: model.progress * 360))
                              
                            
                        }
                        
                        Text(model.stringValue)
                            .font(.largeTitle.weight(.ultraLight))
                            .rotationEffect(.init(degrees: 90))
                            .animation(.none, value: model.progress)
                       
                        
                    }
                    .padding(50)
                    .frame(height: proxy.size.width)
                    .rotationEffect(.init(degrees: -90))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .animation(.easeInOut, value: model.progress)
                }
                
            }
            
            
            
            Button {
                
                if model.isStarted{
                    
                    model.stopTimer()
                    
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                }
                else{
                    
                    model.addNewTimer = true
                }
                
            } label: {
                
                Image(systemName:!model.isStarted ? "timer" : "stop.fill")
                    .font(.largeTitle.bold())
                    .frame(width: 80, height: 80)
                    .background{
                        
                        Circle()
                            .fill(Color("Purple"))
                        
                    }
                    .shadow(color: Color("Purple"), radius: 10, x: 0, y: 0)
            }

            
        }
        .padding()
        .background{
            
            Color("BG")
                .ignoresSafeArea()
        }
        .overlay(content: {
            
            ZStack{
                
                Color.black
                    .opacity(model.addNewTimer ? 0.25 : 0)
                    .onTapGesture {
                        
                        model.hour = 0
                        model.min = 0
                        model.sec = 0
                        model.addNewTimer = false
                    }
                    
                addNewTimerView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .bottom)
                    .offset(y: model.addNewTimer ? 0 : 400)
                
                
                
            }
        })
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect(), perform: { _ in
            
            if model.isStarted{
                
                model.updateTimer()
            }
            
        })
        .alert("Congratulations You did it horray🫣🫣🫣🫣🫣", isPresented: $model.isFinished, actions: {
            
            
            Button("Done",role: .cancel){
                model.stopTimer()
                model.addNewTimer = false
                
            }
            
            Button("Cance",role: .destructive){
                
                model.stopTimer()
            }
        })
        
        
    
        .preferredColorScheme(.dark)
    }
    @ViewBuilder
    func addNewTimerView()->some View{
        
        VStack(spacing:20){
            
            Text("Add New Timer")
                .font(.title.weight(.bold))
            
            
            HStack(spacing:15){
                
                
                Text("\(model.hour)hr")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .padding(.horizontal,20)
                    .background{
                        
                        Capsule()
                            .fill(.gray)
                    }
                    .contextMenu{
                        
                        cusutomContextMenu(maxValue: 12, hint: "hr") { value in
                            model.hour = value
                        }
                    }
                
                
                Text("\(model.min)min")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .padding(.horizontal,20)
                    .background{
                        
                        Capsule()
                            .fill(.gray)
                    }
                    .contextMenu{
                        
                        cusutomContextMenu(maxValue: 60, hint: "min") { value in
                            model.min = value
                        }
                    }
                
                
                Text("\(model.sec)sec")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .padding(.horizontal,20)
                    .background{
                        
                        Capsule()
                            .fill(.gray)
                    }
                    .contextMenu{
                        
                        cusutomContextMenu(maxValue: 60, hint: "sec") { value in
                            model.sec = value
                        }
                    }
                
                
                
                
                
            }
            
            
            Button {
                
                model.startTimer()
                
            } label: {
                
                Text("SAVE")
                    .font(.title3.weight(.semibold))
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .padding(.horizontal,150)
                    .background{
                        
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(Color("Purple"))
                    }
                    .padding(.top,15)
            }

            
        }
        .padding()
        .frame(maxWidth: .infinity,alignment: .center)
        .background{
            
            
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color("BG"))
                .ignoresSafeArea()
            
        }
        
        
    }
    @ViewBuilder
    func cusutomContextMenu(maxValue : Int, hint : String,onClick : @escaping(Int) -> ())->some View{
        
        ForEach(0...maxValue,id:\.self){value in
            
            Button("\(value)\(hint)"){
                
                
                onClick(value)
            }
            
        }
        
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(PomodoroModel())
    }
}
