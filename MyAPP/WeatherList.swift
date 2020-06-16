//
//  WeatherList.swift
//  MyAPP
//
//  Created by Roy on 2020/6/16.
//  Copyright © 2020 Roy. All rights reserved.
//

import SwiftUI

struct WeatherList: View {
    var body: some View {
        
        NavigationView {
            List(fewDaysWeather.indices) { (item) in
                //WeatherRow(weather: fewDaysWeather[item])
                NavigationLink(destination: WeatherDetail(/*weather: fewDaysWeather[item]*/)) {
                    WeatherRow(weather: fewDaysWeather[item]) // Showing rows
                }                
            }
            .navigationBarTitle("Weather")
        }
    }
}

struct WeatherList_Previews: PreviewProvider {
    static var previews: some View {
        WeatherList()
    }
}
