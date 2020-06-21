//
//  WeatherView.swift
//  MyAPP
//
//  Created by Roy on 2020/6/21.
//  Copyright © 2020 Roy. All rights reserved.
//

import SwiftUI
import CoreLocation
import SwiftyJSON
import SDWebImageSwiftUI

struct WeatherView: View {
    
    @State var managerDelegate = LocationManager()
    @State var manager = CLLocationManager()
    @State var forecastData : [dataType] = []
    @State var error = ""
    
    var body: some View {
        
        NavigationView {
        
            VStack {
                //Text("Weather App")
                
                if forecastData.count == 0 {
                    
                    if self.error != "" {
                        
                        Text(error)
                        
                    } else {
                    
                        IndicatorTemp()
                    }
                    
                } else {
                    
                    List(self.forecastData) { i in
                        //Text(i.phrase)
                        
                        HStack(spacing: 18) {
                            
                            AnimatedImage(url: URL(string: i.icon)!)
                                .resizable()
                                .frame(width: 80, height:  45)
                            
                            VStack(alignment: .leading, spacing: 10) {
                                
                                Text(i.phrase)
                                Text("Minimum \(i.min) F")
                                Text("Maximum \(i.max) F")
                            }
                        }
                        .padding(.vertical)
                    }
                }
                
            }
            .navigationBarTitle("Weather Forecast")
            .onAppear {
                
                self.manager.delegate = self.managerDelegate
                
                if CLLocationManager.locationServicesEnabled() {
                    
                    let status = CLLocationManager.authorizationStatus()
                    
                    if status == .denied {
                        
                        self.error = "Please enable location services in settings."
                        
                    } else {
                        
                        self.manager.requestLocation()
                    }
                }
                
                self.manager.requestAlwaysAuthorization()
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("Forecast"), object: nil, queue: .main) { (noti) in
                    //print(noti.userInfo!["data"] as! JSON)
                    
                    self.forecastData.removeAll()
                    
                    let json = noti.userInfo!["data"] as! JSON
                    
                    let forecast = json.dictionary!["DailyForecasts"]?.arrayValue
                
                    for i in 0..<forecast!.count {
                        
                        let temp = forecast![i].dictionary!["Temperature"]
                        
                        let max = temp!["Maximum"].dictionary!["Value"]!.intValue
                        
                        let min = temp!["Minimum"].dictionary!["Value"]!.intValue
                        
                        let	day = forecast![i].dictionary!["Day"]
                        
                        let iconCode = day!.dictionary!["Icon"]!.intValue
                        
                        let iconUrl = "https://developer.accuweather.com/sites/default/files/\(iconCode < 10 ? "0" : "")\(iconCode)-s.png"
                                                                
                        let phrase = day!.dictionary!["IconPhrase"]!.stringValue
                        
                        self.forecastData.append(dataType(id: i, icon: iconUrl, phrase: phrase, min: "\(min)", max: "\(max)"))
                    }
                }
                
                NotificationCenter.default.addObserver(forName: NSNotification.Name("Error"), object: nil, queue: .main) { (_) in
                    
                    if self.error == "" {
                        
                        self.error = "Please enable location services in settings."
                    }
                }
            }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

class LocationManager : NSObject, CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .denied {
            print("denied")
            NotificationCenter.default.post(name: NSNotification.Name("Error"), object: nil)
        }
        else {
            print("authorized")
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error.localizedDescription)
        NotificationCenter.default.post(name: NSNotification.Name("Error"), object: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let lat = "\(locations.last!.coordinate.latitude)"
        let long = "\(locations.last!.coordinate.longitude)"
        
        //let lat = "25.15"
        //let long = "121.77"
        
        print(lat)
        print(long)
    	
        let lkeyurl = "http://dataservice.accuweather.com/locations/v1/cities/geoposition/search?apikey=zpQ7PYGZ18KF3oCYK2AOADh23sTcfAyg&q=\(lat)%2C\(long)"
        
        var req = URLRequest(url: URL(string: lkeyurl)!)
        
        req.httpMethod = "GET"
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: req) { (data, _, err) in
            
            if err != nil {
                
                print((err?.localizedDescription)!)
                return
            }
            
            let json = try! JSON(data: data!)
            
            let lKey = json.dictionary!["Key"]?.stringValue
            
            print(lKey!)
            
            let forecasturl = "http://dataservice.accuweather.com/forecasts/v1/daily/5day/\(lKey!)?apikey=zpQ7PYGZ18KF3oCYK2AOADh23sTcfAyg"
        
            var req1 = URLRequest(url: URL(string: forecasturl)!)
            
            req1.httpMethod = "GET"
            
            let forecastsess = URLSession(configuration: .default)
        
            forecastsess.dataTask(with: req1) { (data1, _, err) in
                
                if err != nil {
                    
                    print((err?.localizedDescription)!)
                    return
                }
                
                let json1 = try! JSON(data: data1!)
                
                print(json1)
                
                NotificationCenter.default.post(name: NSNotification.Name("Forecast"), object: nil, userInfo: ["data":json1])
                
            }
            .resume()
        }
        .resume()
    }
}

struct dataType : Identifiable {
    
    var id : Int
    var icon : String
    var phrase : String
    var min : String
    var max : String
}

struct IndicatorTemp : UIViewRepresentable {

    func makeUIView(context: UIViewRepresentableContext<IndicatorTemp>) -> UIActivityIndicatorView {
        
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<IndicatorTemp>) {
        
        
    }
}


//let myApiKey = "zpQ7PYGZ18KF3oCYK2AOADh23sTcfAyg"

