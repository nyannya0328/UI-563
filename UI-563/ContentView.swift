//
//  ContentView.swift
//  UI-563
//
//  Created by nyannyan0328 on 2022/05/16.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model : PomodoroModel
    var body: some View {
      Home()
            .environmentObject(model)

             
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

