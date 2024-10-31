//
//  model.swift
//  SwiftUI-wearher
//
//  Created by Haidarov N on 25/10/24.
//

//import SwiftUI
//import Foundation
//import CoreLocation
//
//
//struct weatherDate{
//    let locationname: String
//    let tempteture: Double
//    let condition: String
//}
//
//struct weatherResponse: Codable{
//    let name: String
//    let main: mainWeather
//    let weather: [weather]
//}
//
//struct mainWeather: Codable{
//    let temp: Double
//   
//}
//
//struct weather: Codable{
//    let description: String
//}
//
//
//class locationManager: NSObject, ObservableObject, CLLocationManagerDelegate{
//    
//   
//    
//    private let locationManager = CLLocationManager()
//
//    @Published var location: CLLocation?
//    
//    override init(){
//        super.init()
//        self.locationManager.delegate = self
//         
//    }
//    
//    
//    func requeslocation(){
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//        
//    }
//    
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]){
//        guard let location = locations.last else { return }
//        self.location = location
//        locationManager.startUpdatingLocation()
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print(error.localizedDescription)
//        
//    }
//}
//


//import Foundation
//
//struct WeatherResponse: Codable {
//    let current: CurrentWeather
//    let hourly: HourlyWeather
//}
//
//struct CurrentWeather: Codable {
//    let time: String
//    let temperature2m: Double
//    let windSpeed10m: Double
//    
//    enum CodingKeys: String, CodingKey {
//        case time
//        case temperature2m = "temperature_2m"
//        case windSpeed10m = "wind_speed_10m"
//    }
//}
//
//struct HourlyWeather: Codable {
//    let time: [String]
//    let windSpeed10m: [Double]
//    let temperature2m: [Double]
//    let relativeHumidity2m: [Int]
//    
//    enum CodingKeys: String, CodingKey {
//        case time
//        case windSpeed10m = "wind_speed_10m"
//        case temperature2m = "temperature_2m"
//        case relativeHumidity2m = "relative_humidity_2m"
//    }
//}
//
//
//import Foundation
//
//class WeatherViewModel: ObservableObject {
//    @Published var weather: WeatherResponse?
//
//    func fetchWeather() {
//        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=52.52&longitude=13.41&current=temperature_2m,wind_speed_10m&hourly=temperature_2m,relative_humidity_2m,wind_speed_10m"
//        
//        guard let url = URL(string: urlString) else {
//            print("Invalid URL")
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let data = data {
//                do {
//                    let decodedResponse = try JSONDecoder().decode(WeatherResponse.self, from: data)
//                    DispatchQueue.main.async {
//                        self.weather = decodedResponse
//                    }
//                } catch {
//                    print("Failed to decode JSON: \(error)")
//                }
//            } else if let error = error {
//                print("Request failed: \(error)")
//            }
//        }.resume()
//    }
//}
