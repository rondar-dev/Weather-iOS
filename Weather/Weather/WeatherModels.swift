//
//  WeatherModels.swift
//  Weather
//
//  Sample weather data used by the home, 7-day forecast and saved cities screens.
//

import SwiftUI

enum WeatherCondition: String {
    case sunny = "Sunny"
    case partlyCloudy = "Partly Cloudy"
    case cloudy = "Cloudy"
    case rain = "Rain"
    case thunderstorm = "Thunderstorms"
    case snow = "Snow"
    case clearNight = "Clear"

    var symbolName: String {
        switch self {
        case .sunny: return "sun.max.fill"
        case .partlyCloudy: return "cloud.sun.fill"
        case .cloudy: return "cloud.fill"
        case .rain: return "cloud.rain.fill"
        case .thunderstorm: return "cloud.bolt.rain.fill"
        case .snow: return "cloud.snow.fill"
        case .clearNight: return "moon.stars.fill"
        }
    }

    var iconColor: Color {
        switch self {
        case .sunny: return .yellow
        case .partlyCloudy: return Color(red: 1.0, green: 0.85, blue: 0.4)
        case .cloudy: return Color(white: 0.92)
        case .rain: return Color(red: 0.6, green: 0.85, blue: 1.0)
        case .thunderstorm: return Color(red: 1.0, green: 0.9, blue: 0.5)
        case .snow: return .white
        case .clearNight: return Color(red: 0.95, green: 0.92, blue: 0.75)
        }
    }

    var gradient: [Color] {
        switch self {
        case .sunny:
            return [Color(red: 0.20, green: 0.55, blue: 0.95), Color(red: 0.45, green: 0.78, blue: 1.0)]
        case .partlyCloudy:
            return [Color(red: 0.25, green: 0.50, blue: 0.85), Color(red: 0.55, green: 0.75, blue: 0.95)]
        case .cloudy:
            return [Color(red: 0.38, green: 0.47, blue: 0.60), Color(red: 0.62, green: 0.70, blue: 0.80)]
        case .rain:
            return [Color(red: 0.22, green: 0.30, blue: 0.45), Color(red: 0.40, green: 0.52, blue: 0.68)]
        case .thunderstorm:
            return [Color(red: 0.15, green: 0.17, blue: 0.30), Color(red: 0.35, green: 0.35, blue: 0.52)]
        case .snow:
            return [Color(red: 0.50, green: 0.62, blue: 0.80), Color(red: 0.78, green: 0.86, blue: 0.95)]
        case .clearNight:
            return [Color(red: 0.06, green: 0.08, blue: 0.25), Color(red: 0.22, green: 0.20, blue: 0.48)]
        }
    }
}

struct HourlyForecast: Identifiable {
    let id = UUID()
    let time: String
    let condition: WeatherCondition
    let temperature: Int
    let precipitationChance: Int
}

struct DailyForecast: Identifiable {
    let id = UUID()
    let day: String
    let condition: WeatherCondition
    let low: Int
    let high: Int
    let precipitationChance: Int
}

struct CityWeather: Identifiable {
    let id = UUID()
    let name: String
    let country: String
    let localTime: String
    let condition: WeatherCondition
    let temperature: Int
    let feelsLike: Int
    let high: Int
    let low: Int
    let humidity: Int
    let windSpeed: Int
    let uvIndex: Int
    let visibility: Int
    let hourly: [HourlyForecast]
    let daily: [DailyForecast]
}

enum SampleWeather {
    static let cities: [CityWeather] = [sanFrancisco, newYork, london, tokyo, reykjavik]

    static let sanFrancisco = CityWeather(
        name: "San Francisco", country: "United States", localTime: "10:24 AM",
        condition: .partlyCloudy, temperature: 18, feelsLike: 17, high: 21, low: 12,
        humidity: 68, windSpeed: 19, uvIndex: 5, visibility: 16,
        hourly: hourly(start: 10, temps: [18, 19, 20, 21, 21, 20, 19, 17, 15, 14, 13, 12],
                       conditions: [.partlyCloudy, .partlyCloudy, .sunny, .sunny, .sunny, .partlyCloudy,
                                    .partlyCloudy, .cloudy, .cloudy, .clearNight, .clearNight, .clearNight],
                       rain: [0, 0, 0, 0, 0, 5, 10, 10, 15, 5, 0, 0]),
        daily: daily(highs: [21, 22, 19, 17, 18, 20, 23], lows: [12, 13, 12, 11, 11, 12, 14],
                     conditions: [.partlyCloudy, .sunny, .cloudy, .rain, .partlyCloudy, .sunny, .sunny],
                     rain: [10, 0, 20, 70, 30, 0, 0])
    )

    static let newYork = CityWeather(
        name: "New York", country: "United States", localTime: "1:24 PM",
        condition: .rain, temperature: 11, feelsLike: 8, high: 13, low: 7,
        humidity: 84, windSpeed: 24, uvIndex: 2, visibility: 8,
        hourly: hourly(start: 13, temps: [11, 11, 12, 11, 10, 10, 9, 9, 8, 8, 7, 7],
                       conditions: [.rain, .rain, .thunderstorm, .rain, .rain, .cloudy,
                                    .cloudy, .cloudy, .cloudy, .rain, .rain, .cloudy],
                       rain: [80, 85, 90, 70, 60, 40, 30, 30, 35, 55, 60, 40]),
        daily: daily(highs: [13, 12, 15, 17, 16, 14, 12], lows: [7, 6, 8, 10, 9, 8, 6],
                     conditions: [.rain, .cloudy, .partlyCloudy, .sunny, .sunny, .cloudy, .rain],
                     rain: [85, 40, 10, 0, 5, 30, 65])
    )

    static let london = CityWeather(
        name: "London", country: "United Kingdom", localTime: "6:24 PM",
        condition: .cloudy, temperature: 9, feelsLike: 7, high: 11, low: 5,
        humidity: 79, windSpeed: 15, uvIndex: 1, visibility: 10,
        hourly: hourly(start: 18, temps: [9, 8, 8, 7, 7, 6, 6, 6, 5, 5, 5, 6],
                       conditions: [.cloudy, .cloudy, .cloudy, .rain, .rain, .cloudy,
                                    .cloudy, .clearNight, .clearNight, .clearNight, .cloudy, .cloudy],
                       rain: [20, 25, 30, 55, 60, 35, 20, 10, 5, 5, 15, 20]),
        daily: daily(highs: [11, 10, 12, 13, 11, 9, 10], lows: [5, 4, 6, 7, 6, 3, 4],
                     conditions: [.cloudy, .rain, .partlyCloudy, .partlyCloudy, .rain, .cloudy, .sunny],
                     rain: [30, 75, 20, 15, 60, 30, 5])
    )

    static let tokyo = CityWeather(
        name: "Tokyo", country: "Japan", localTime: "3:24 AM",
        condition: .clearNight, temperature: 14, feelsLike: 13, high: 20, low: 12,
        humidity: 62, windSpeed: 8, uvIndex: 0, visibility: 20,
        hourly: hourly(start: 3, temps: [14, 13, 13, 12, 13, 15, 16, 18, 19, 20, 20, 19],
                       conditions: [.clearNight, .clearNight, .clearNight, .clearNight, .partlyCloudy, .sunny,
                                    .sunny, .sunny, .sunny, .sunny, .partlyCloudy, .partlyCloudy],
                       rain: [0, 0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 10]),
        daily: daily(highs: [20, 21, 19, 18, 22, 23, 21], lows: [12, 13, 13, 12, 14, 15, 14],
                     conditions: [.sunny, .sunny, .partlyCloudy, .rain, .sunny, .sunny, .partlyCloudy],
                     rain: [0, 0, 15, 60, 5, 0, 10])
    )

    static let reykjavik = CityWeather(
        name: "Reykjavík", country: "Iceland", localTime: "6:24 PM",
        condition: .snow, temperature: -2, feelsLike: -7, high: 0, low: -5,
        humidity: 88, windSpeed: 32, uvIndex: 0, visibility: 4,
        hourly: hourly(start: 18, temps: [-2, -2, -3, -3, -4, -4, -5, -5, -5, -4, -4, -3],
                       conditions: [.snow, .snow, .snow, .cloudy, .cloudy, .clearNight,
                                    .clearNight, .clearNight, .cloudy, .snow, .snow, .snow],
                       rain: [70, 75, 60, 40, 30, 10, 5, 5, 25, 55, 65, 70]),
        daily: daily(highs: [0, 1, -1, -3, 0, 2, 1], lows: [-5, -4, -6, -8, -5, -2, -3],
                     conditions: [.snow, .cloudy, .snow, .snow, .partlyCloudy, .cloudy, .rain],
                     rain: [70, 30, 80, 85, 20, 35, 60])
    )

    private static func hourly(start: Int, temps: [Int], conditions: [WeatherCondition], rain: [Int]) -> [HourlyForecast] {
        temps.indices.map { index in
            let hour = (start + index) % 24
            let label: String
            if index == 0 {
                label = "Now"
            } else {
                let displayHour = hour % 12 == 0 ? 12 : hour % 12
                label = "\(displayHour) \(hour < 12 ? "AM" : "PM")"
            }
            return HourlyForecast(time: label, condition: conditions[index],
                                  temperature: temps[index], precipitationChance: rain[index])
        }
    }

    private static let weekdays = ["Today", "Fri", "Sat", "Sun", "Mon", "Tue", "Wed"]

    private static func daily(highs: [Int], lows: [Int], conditions: [WeatherCondition], rain: [Int]) -> [DailyForecast] {
        highs.indices.map { index in
            DailyForecast(day: weekdays[index], condition: conditions[index],
                          low: lows[index], high: highs[index], precipitationChance: rain[index])
        }
    }
}

/// Glass-style card used on every screen.
struct WeatherCard<Content: View>: View {
    let title: String
    let systemImage: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(title.uppercased(), systemImage: systemImage)
                .font(.caption.weight(.semibold))
                .foregroundStyle(.white.opacity(0.7))
            content
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

struct WeatherBackground: View {
    let condition: WeatherCondition

    var body: some View {
        LinearGradient(colors: condition.gradient, startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}
