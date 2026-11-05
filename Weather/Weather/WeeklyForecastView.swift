//
//  WeeklyForecastView.swift
//  Weather
//
//  7-day forecast for the selected city.
//

import SwiftUI

struct WeeklyForecastView: View {
    let city: CityWeather
    @Environment(\.dismiss) var dismiss

    private var weekLow: Int { city.daily.map { $0.low }.min() ?? city.low }
    private var weekHigh: Int { city.daily.map { $0.high }.max() ?? city.high }

    var body: some View {
        ZStack {
            WeatherBackground(condition: city.condition)

            VStack(spacing: 0) {
                SheetHeader(title: "7-Day Forecast", subtitle: city.name) {
                    dismiss()
                }

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        summary

                        GlassCard(title: "Next 7 days", systemImage: "calendar") {
                            VStack(spacing: 0) {
                                ForEach(city.daily) { day in
                                    DailyRow(day: day, weekLow: weekLow, weekHigh: weekHigh)
                                    if day.id != city.daily.last?.id {
                                        Rectangle()
                                            .fill(Color.white.opacity(0.15))
                                            .frame(height: 1)
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                }
            }
        }
        .foregroundColor(.white)
    }

    private var summary: some View {
        let rainyDays = city.daily.filter { $0.precipitationChance >= 50 }.count
        return HStack(spacing: 14) {
            Image(systemName: city.condition.symbolName)
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 40))
                .frame(width: 56)
            VStack(alignment: .leading, spacing: 4) {
                Text("Temperatures from \(weekLow)° to \(weekHigh)°")
                    .font(.system(size: 17, weight: .semibold))
                Text(rainyDays == 0 ? "No rain expected this week" : "Rain likely on \(rainyDays) day\(rainyDays == 1 ? "" : "s")")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            Spacer(minLength: 0)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.white.opacity(0.16))
        )
    }
}

struct DailyRow: View {
    let day: DailyForecast
    let weekLow: Int
    let weekHigh: Int

    var body: some View {
        HStack(spacing: 12) {
            Text(day.day)
                .font(.system(size: 17, weight: .semibold))
                .frame(width: 56, alignment: .leading)

            VStack(spacing: 2) {
                Image(systemName: day.condition.symbolName)
                    .symbolRenderingMode(.multicolor)
                    .font(.system(size: 22))
                    .frame(height: 24)
                if day.precipitationChance >= 20 {
                    Text("\(day.precipitationChance)%")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(Color(red: 0.62, green: 0.86, blue: 1.0))
                }
            }
            .frame(width: 40)

            Text("\(day.low)°")
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(.white.opacity(0.7))
                .frame(width: 36, alignment: .trailing)

            TemperatureRangeBar(low: day.low, high: day.high, weekLow: weekLow, weekHigh: weekHigh)
                .frame(height: 6)

            Text("\(day.high)°")
                .font(.system(size: 17, weight: .semibold))
                .frame(width: 36, alignment: .trailing)
        }
        .padding(.vertical, 12)
    }
}

/// Capsule showing where a day's range sits within the week's range.
struct TemperatureRangeBar: View {
    let low: Int
    let high: Int
    let weekLow: Int
    let weekHigh: Int

    var body: some View {
        GeometryReader { geometry in
            let span = CGFloat(max(weekHigh - weekLow, 1))
            let start = CGFloat(low - weekLow) / span * geometry.size.width
            let width = max(CGFloat(high - low) / span * geometry.size.width, 6)

            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color.black.opacity(0.18))
                Capsule()
                    .fill(LinearGradient(colors: [Color(red: 0.45, green: 0.85, blue: 0.95),
                                                  Color(red: 1.0, green: 0.78, blue: 0.30)],
                                         startPoint: .leading, endPoint: .trailing))
                    .frame(width: width)
                    .offset(x: start)
            }
        }
    }
}

struct WeeklyForecastView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyForecastView(city: CityWeather.sampleCities[0])
    }
}
