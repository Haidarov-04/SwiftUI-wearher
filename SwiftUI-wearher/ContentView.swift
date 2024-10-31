//
//  ContentView.swift
//  SwiftUI-wearher
//
//  Created by Haidarov N on 23/10/23.


import SwiftUI

struct ContentView: View {
    @State private var isNight = false
    
    
    @State private var Weather : weatherCity?
    @State private var city: String = "Khujand"
    @State private var currentTime = Date()
    
        
        
        
    

    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    
    var body: some View {
        ZStack {
           
            BackgroundView(isNight: $isNight)
            
            VStack{
                
                
                 
                    
                cityName(city: city)
//
                
                onlyWestherView(isNight: $isNight, image: Weather?.current.weather_icons[0] ?? "cloud.sun.fill",
                                temprature: Weather?.current.temperature ?? 0)
                
                
                    
                  
                    
                    HStack(spacing: 20){
                        WeatherDayView(day: "Mon",
                                       ImageWeather: "cloud.sun.fill",
                                       temprature: 72)
                        
                        WeatherDayView(day: "Tue",
                                       ImageWeather: "sun.max.fill",
                                       temprature: 88)
                        
                        WeatherDayView(day: "Wde",
                                       ImageWeather: "wind.snow",
                                       temprature: 60)
                        
                        WeatherDayView(day: "Thu",
                                       ImageWeather: "sunset.fill",
                                       temprature: 68)
                        
                        WeatherDayView(day: "Fri",
                                       ImageWeather: "snow",
                                       temprature: 55)
                    }
                    
                    
                    Spacer()
                    
//                    Button{
//                        isNight.toggle()
//                    }label: {
//                        changeDay(title: "Change Day", textColor: .blue, background: .white)
//                      
//                    }
              
                    Spacer()
                    
                
                
            }
            .onAppear{
                
                    apiWeather().getWeather(city: city){ (result) in
                        self.Weather = result
//                        print(Weather?.current.weather_icons[0])
                        
                        
                    }
                
            }
            .onReceive(timer) { input in
                                currentTime = input
                                updateIsNightStatus()
                            }
            
        }
        
    }
        
    func formattedTime(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter.string(from: date)
    }
    
    // Helper function to update isNight status based on Weather's localtime
    func updateIsNightStatus() {
        // Assuming Weather?.location.localtime is a string in the format "yyyy-MM-dd HH:mm"
        let localtimeString = Weather?.location.localtime ?? "2024-10-30 15:00"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        if let localtimeDate = dateFormatter.date(from: localtimeString) {
            if currentTime > localtimeDate {
                isNight = true
            }else{
                isNight = false
            }
        } else {
            print("Failed to convert localtime string to Date")
        }
    }
}

#Preview {
    ContentView()
}

struct WeatherDayView: View {
    var day : String
    var ImageWeather : String
    var temprature : Int
    
    var body: some View {
        
            VStack{
                Text(day)
                    .font(.system(size: 16, weight: .medium, design: .default))
                    .foregroundColor(.white)
                
                Image(systemName: ImageWeather)
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 50, height: 50)
                Text("\(temprature)°")
                    .foregroundColor(.white)
            }
            
        
    }
}

struct BackgroundView: View {
    
    
    @Binding  var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray:.white]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct cityName: View {
    var city: String
    
    var body: some View {
        Text(city)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}






struct onlyWestherView: View {
    
    @Binding var isNight: Bool
    var image: String
    var temprature: Double
    
    
    var body: some View {
        Image(systemName: image )
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 200, height: 200)
        Text("\(temprature)°")
            .font(.system(size: 70, weight: .medium))
            .foregroundColor(.white)
            .padding(.bottom, 40)
            
    }
}


struct changeDay: View {
    
    var title: String
    var textColor: Color
    var background: Color
    var body: some View {
        Text(title)
            .frame(width: 280, height: 50)
            .background(background)
            .foregroundColor(textColor)
            .font(.system(size: 20, weight: .bold, design: .default))
            .cornerRadius(10)
    }
}
