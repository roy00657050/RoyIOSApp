//
//  WeatherDetail.swift
//  MyAPP
//
//  Created by Roy on 2020/6/16.
//  Copyright © 2020 Roy. All rights reserved.
//

import SwiftUI

struct WeatherDetail: View {
    
    var weather: Weather = selectedWeather
    
    var body: some View {
        VStack {
            Image(systemName: "sun.max.fill")
            .resizable()
            .scaledToFill()
                .frame(height: 300)
            .clipped()
            
            Text("Date : " + weather.date).padding()
            Text("Week : " + weather.week).padding()
            Text("Weather : " + weather.weather).padding()
            Text("Temperature : " + weather.temperature).padding()
        }
        .navigationBarTitle(weather.date)
    }
}

/*struct WeatherDetail_Previews: PreviewProvider {
    static var previews: some View {
        WeatherDetail()
    }
}*/
