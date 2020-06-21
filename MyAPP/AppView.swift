//
//  AppView.swift
//  MyAPP
//
//  Created by Roy on 2020/6/16.
//  Copyright © 2020 Roy. All rights reserved.
//

import SwiftUI

struct AppView: View {
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                ContentView()
            }
                .tabItem {
                    Image(systemName: "b.circle")
                    Text("Notes")
            }
            .tag(0)
            
            NavigationView {
                //WeatherList()
                WeatherView()
            }
                .tabItem {
                    Image(systemName: "cloud")
                    Text("Weather")
            }
            .tag(1)
        }
        .accentColor(.yellow)
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
