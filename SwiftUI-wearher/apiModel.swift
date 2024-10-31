//
//  apiModel.swift
//  SwiftUI-wearher
//
//  Created by Haidarov N on 10/29/24.


import SwiftUI

struct weatherCity: Codable {
    let request: request
    let location: location
    let current: current
}



struct request: Codable {
    let type: String
    let query: String
    let language: String
    let unit: String
}


struct location: Codable {
    let name: String
    let country: String
    let region: String
    let lat: String
    let lon: String
    let timezone_id: String
    let localtime: String
    let localtime_epoch: Double
    let utc_offset: String
}


struct current : Codable {
    let observation_time: String
    let temperature: Double
    let weather_code: Int
    let weather_icons: [String]
    let weather_descriptions: [String]
    let wind_speed: Double
    let wind_degree: Double
    let wind_dir: String
    let pressure: Double
    let precip: Double
    let humidity: Double
    let cloudcover: Double
    let feelslike: Double
    let uv_index: Double
    let visibility: Double
}

