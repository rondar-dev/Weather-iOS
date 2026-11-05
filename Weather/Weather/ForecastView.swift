//
//  ForecastView.swift
//  Weather
//
//  The 7-day forecast screen.
//

import SwiftUI

struct ForecastView: View {
    let city: CityWeather

    private var weekLow: Int { city.daily.map(\.low).min() ?? city.low }
    private var weekHigh: Int { city.daily.map(\.high).max() ?? city.high }

    var body: some View {
        ZStack {
            WeatherBackground(condition: city.condition)

            ScrollView {
                VStack(spacing: 16) {
                    VStack(spacing: 4) {
                        Text(city.name)
                            .font(.title.weight(.semibold))
                        Text("\(city.temperature)° · \(city.condition.rawValue)")
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.8))
                    }
                    .foregroundStyle(.white)
                    .padding(.top, 8)

                    WeatherCard(title: "7-Day Forecast", systemImage: "calendar") {
                        VStack(spacing: 0) {
                            ForEach(Array(city.daily.enumerated()), id: \.element.id) { index, day in
                                if index > 0 {
                                    Divider().overlay(Color.white.opacity(0.25))
                                }
                                DailyForecastRow(day: day, weekLow: weekLow, weekHigh: weekHigh)
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
            }
        }
        .navigationTitle("7-Day Forecast")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DailyForecastRow: View {
    let day: DailyForecast
    let weekLow: Int
    let weekHigh: Int

    var body: some View {
        HStack(spacing: 12) {
            Text(day.day)
                .font(.headline)
                .frame(width: 56, alignment: .leading)

            VStack(spacing: 2) {
                Image(systemName: day.condition.symbolName)
                    .font(.title3)
                    .foregroundStyle(day.condition.iconColor)
                if day.precipitationChance >= 20 {
                    Text("\(day.precipitationChance)%")
                        .font(.caption2.weight(.semibold))
                        .foregroundStyle(Color(red: 0.6, green: 0.85, blue: 1.0))
                }
            }
            .frame(width: 40)

            Text("\(day.low)°")
                .font(.headline)
                .foregroundStyle(.white.opacity(0.65))
                .frame(width: 36, alignment: .trailing)

            TemperatureRangeBar(low: day.low, high: day.high, weekLow: weekLow, weekHigh: weekHigh)
                .frame(height: 6)

            Text("\(day.high)°")
                .font(.headline)
                .frame(width: 36, alignment: .leading)
        }
        .foregroundStyle(.white)
        .padding(.vertical, 12)
    }
}

struct TemperatureRangeBar: View {
    let low: Int
    let high: Int
    let weekLow: Int
    let weekHigh: Int

    var body: some View {
        GeometryReader { proxy in
            let span = CGFloat(max(weekHigh - weekLow, 1))
            let start = CGFloat(low - weekLow) / span * proxy.size.width
            let width = max(CGFloat(high - low) / span * proxy.size.width, 6)

            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.black.opacity(0.2))
                Capsule()
                    .fill(LinearGradient(colors: [Color(red: 0.4, green: 0.8, blue: 1.0), .yellow, .orange],
                                         startPoint: .leading, endPoint: .trailing))
                    .frame(width: width)
                    .offset(x: start)
            }
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ForecastView(city: SampleWeather.sanFrancisco)
        }
    }
}
