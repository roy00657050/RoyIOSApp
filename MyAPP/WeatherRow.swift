//
//  WeatherRow.swift
//  MyAPP
//
//  Created by Roy on 2020/6/16.
//  Copyright © 2020 Roy. All rights reserved.
//

import SwiftUI

struct WeatherRow: View {
    
    let weather: Weather
    
    var body: some View {
        HStack {
            Image(systemName: "sun.max.fill")
            .resizable()
            .scaledToFill()
            .frame(width: 80, height: 80)
            .clipped()
            
            VStack(alignment: .leading) {
                Text("Date : " + weather.date)
            }
            Spacer()
        }
    }
}

struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(weather: Weather(date: "2022-02-22", week: "GoodDay", temperature: "22C", weather: "Great"))
            .previewLayout(.sizeThatFits)
    }
}
