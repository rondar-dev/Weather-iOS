//
//  WeatherSampleData.swift
//  Weather
//
//  Sample weather models and data used by the app screens.
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

    var gradient: [Color] {
        switch self {
        case .sunny:
            return [Color(red: 0.16, green: 0.50, blue: 0.93), Color(red: 0.44, green: 0.76, blue: 0.98)]
        case .partlyCloudy:
            return [Color(red: 0.23, green: 0.45, blue: 0.80), Color(red: 0.56, green: 0.72, blue: 0.90)]
        case .cloudy:
            return [Color(red: 0.36, green: 0.43, blue: 0.54), Color(red: 0.62, green: 0.68, blue: 0.76)]
        case .rain:
            return [Color(red: 0.20, green: 0.27, blue: 0.40), Color(red: 0.40, green: 0.50, blue: 0.62)]
        case .thunderstorm:
            return [Color(red: 0.14, green: 0.14, blue: 0.28), Color(red: 0.34, green: 0.30, blue: 0.50)]
        case .snow:
            return [Color(red: 0.45, green: 0.58, blue: 0.75), Color(red: 0.78, green: 0.85, blue: 0.93)]
        case .clearNight:
            return [Color(red: 0.05, green: 0.08, blue: 0.24), Color(red: 0.20, green: 0.24, blue: 0.48)]
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
    let high: Int
    let low: Int
    let feelsLike: Int
    let humidity: Int
    let windSpeed: Int
    let uvIndex: Int
    let hourly: [HourlyForecast]
    let daily: [DailyForecast]
}

extension CityWeather {
    static let sampleCities: [CityWeather] = [
        CityWeather(
            name: "San Francisco", country: "United States", localTime: "10:24 AM",
            condition: .partlyCloudy, temperature: 18, high: 21, low: 12,
            feelsLike: 17, humidity: 68, windSpeed: 19, uvIndex: 5,
            hourly: makeHourly(start: 10, temps: [18, 19, 20, 21, 21, 20, 19, 17, 15, 14, 13, 12],
                               conditions: [.partlyCloudy, .partlyCloudy, .sunny, .sunny, .sunny, .partlyCloudy,
                                            .partlyCloudy, .cloudy, .cloudy, .clearNight, .clearNight, .clearNight],
                               rain: [0, 0, 0, 0, 0, 5, 10, 10, 15, 10, 5, 0]),
            daily: makeDaily(conditions: [.partlyCloudy, .sunny, .sunny, .cloudy, .rain, .partlyCloudy, .sunny],
                             lows: [12, 12, 13, 13, 11, 11, 12],
                             highs: [21, 23, 24, 20, 17, 19, 22],
                             rain: [10, 0, 0, 20, 70, 30, 0])
        ),
        CityWeather(
            name: "London", country: "United Kingdom", localTime: "6:24 PM",
            condition: .rain, temperature: 11, high: 13, low: 8,
            feelsLike: 9, humidity: 87, windSpeed: 24, uvIndex: 1,
            hourly: makeHourly(start: 18, temps: [11, 11, 10, 10, 9, 9, 9, 8, 8, 8, 8, 9],
                               conditions: [.rain, .rain, .rain, .cloudy, .cloudy, .cloudy,
                                            .rain, .rain, .cloudy, .cloudy, .partlyCloudy, .partlyCloudy],
                               rain: [80, 75, 60, 40, 30, 30, 55, 60, 35, 20, 10, 10]),
            daily: makeDaily(conditions: [.rain, .cloudy, .partlyCloudy, .rain, .thunderstorm, .cloudy, .partlyCloudy],
                             lows: [8, 7, 7, 9, 10, 8, 7],
                             highs: [13, 12, 14, 13, 15, 12, 13],
                             rain: [80, 30, 10, 70, 85, 40, 20])
        ),
        CityWeather(
            name: "Tokyo", country: "Japan", localTime: "3:24 AM",
            condition: .clearNight, temperature: 14, high: 20, low: 12,
            feelsLike: 13, humidity: 58, windSpeed: 8, uvIndex: 0,
            hourly: makeHourly(start: 3, temps: [14, 13, 13, 12, 13, 15, 16, 18, 19, 20, 20, 19],
                               conditions: [.clearNight, .clearNight, .clearNight, .clearNight, .partlyCloudy, .sunny,
                                            .sunny, .sunny, .sunny, .sunny, .partlyCloudy, .partlyCloudy],
                               rain: [0, 0, 0, 0, 0, 0, 0, 0, 5, 5, 10, 10]),
            daily: makeDaily(conditions: [.sunny, .sunny, .partlyCloudy, .rain, .rain, .cloudy, .sunny],
                             lows: [12, 13, 14, 14, 13, 12, 12],
                             highs: [20, 21, 21, 18, 17, 19, 22],
                             rain: [0, 0, 20, 75, 80, 30, 0])
        ),
        CityWeather(
            name: "Sydney", country: "Australia", localTime: "5:24 AM",
            condition: .sunny, temperature: 24, high: 29, low: 19,
            feelsLike: 25, humidity: 52, windSpeed: 15, uvIndex: 9,
            hourly: makeHourly(start: 5, temps: [24, 24, 25, 26, 27, 28, 29, 29, 28, 27, 25, 23],
                               conditions: [.sunny, .sunny, .sunny, .sunny, .sunny, .sunny,
                                            .partlyCloudy, .partlyCloudy, .thunderstorm, .thunderstorm, .cloudy, .clearNight],
                               rain: [0, 0, 0, 0, 0, 10, 20, 30, 60, 65, 30, 10]),
            daily: makeDaily(conditions: [.sunny, .thunderstorm, .partlyCloudy, .sunny, .sunny, .partlyCloudy, .rain],
                             lows: [19, 20, 19, 18, 19, 20, 18],
                             highs: [29, 27, 26, 28, 30, 28, 24],
                             rain: [10, 70, 20, 0, 0, 15, 65])
        ),
        CityWeather(
            name: "Reykjavík", country: "Iceland", localTime: "6:24 PM",
            condition: .snow, temperature: -2, high: 1, low: -5,
            feelsLike: -8, humidity: 81, windSpeed: 32, uvIndex: 0,
            hourly: makeHourly(start: 18, temps: [-2, -2, -3, -3, -4, -4, -5, -5, -4, -3, -2, -1],
                               conditions: [.snow, .snow, .snow, .cloudy, .cloudy, .clearNight,
                                            .clearNight, .clearNight, .cloudy, .cloudy, .snow, .snow],
                               rain: [70, 65, 50, 30, 20, 10, 5, 5, 20, 30, 55, 60]),
            daily: makeDaily(conditions: [.snow, .cloudy, .snow, .snow, .partlyCloudy, .cloudy, .snow],
                             lows: [-5, -6, -4, -3, -7, -6, -4],
                             highs: [1, 0, 2, 1, -1, 0, 2],
                             rain: [70, 30, 60, 80, 10, 25, 65])
        )
    ]

    private static func makeHourly(start: Int, temps: [Int], conditions: [WeatherCondition], rain: [Int]) -> [HourlyForecast] {
        var items: [HourlyForecast] = []
        for index in 0..<temps.count {
            let label: String
            if index == 0 {
                label = "Now"
            } else {
                let hour = (start + index) % 24
                let display = hour % 12 == 0 ? 12 : hour % 12
                label = "\(display)\(hour < 12 ? "AM" : "PM")"
            }
            items.append(HourlyForecast(time: label, condition: conditions[index],
                                        temperature: temps[index], precipitationChance: rain[index]))
        }
        return items
    }

    private static func makeDaily(conditions: [WeatherCondition], lows: [Int], highs: [Int], rain: [Int]) -> [DailyForecast] {
        let days = ["Today", "Fri", "Sat", "Sun", "Mon", "Tue", "Wed"]
        var items: [DailyForecast] = []
        for index in 0..<days.count {
            items.append(DailyForecast(day: days[index], condition: conditions[index],
                                       low: lows[index], high: highs[index], precipitationChance: rain[index]))
        }
        return items
    }
}

/// Full-screen gradient that matches the current weather condition.
struct WeatherBackground: View {
    let condition: WeatherCondition

    var body: some View {
        LinearGradient(colors: condition.gradient, startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}

/// Rounded translucent card used for grouped content on every screen.
struct GlassCard<Content: View>: View {
    let title: String
    let systemImage: String
    let content: Content

    init(title: String, systemImage: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.systemImage = systemImage
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Label(title.uppercased(), systemImage: systemImage)
                .font(.caption.weight(.semibold))
                .foregroundColor(.white.opacity(0.7))
            Rectangle()
                .fill(Color.white.opacity(0.2))
                .frame(height: 1)
            content
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.white.opacity(0.16))
        )
    }
}

/// Title bar with a close button for the screens shown as sheets.
struct SheetHeader: View {
    let title: String
    let subtitle: String
    let onClose: () -> Void

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.75))
            }
            Spacer()
            Button(action: onClose) {
                Image(systemName: "xmark")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 36, height: 36)
                    .background(Circle().fill(Color.white.opacity(0.2)))
            }
            .accessibilityLabel("Close")
        }
        .foregroundColor(.white)
        .padding(.horizontal, 20)
        .padding(.top, 20)
        .padding(.bottom, 8)
    }
}
