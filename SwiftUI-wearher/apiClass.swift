//
//  apiClass.swift
//  SwiftUI-wearher
//
//  Created by Haidarov N on 10/29/24.
//

import Swift
import Foundation



class apiWeather: ObservableObject {
    func getWeather(city: String, completion: @escaping (weatherCity?) -> Void) {
        let urlString = "https://api.weatherstack.com/current?access_key=ab6eb9a3ae8dd48ed1855e963efd4b8e&query=\(city)"
        
        guard let url = URL(string: urlString) else {
            print("URL error")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                print("No data error")
                completion(nil)
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                    print("JSON Response: \(jsonString)")
                }
            
            
            do {
                let weather = try JSONDecoder().decode(weatherCity.self, from: data)
                DispatchQueue.main.async {
                    completion(weather)
                }
            } catch {
                print("Failed to decode JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }
        .resume()
    }
}
