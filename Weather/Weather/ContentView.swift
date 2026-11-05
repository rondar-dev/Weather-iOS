//
//  ContentView.swift
//  Weather
//
//  Created by Anup Harbade on 2/24/22.
//

import SwiftUI

struct ContentView: View {
    @State private var cities: [CityWeather] = CityWeather.sampleCities
    @State private var selectedCityID: UUID? = nil
    @State private var showingWeekly = false
    @State private var showingCities = false

    private var city: CityWeather {
        cities.first(where: { $0.id == selectedCityID }) ?? cities[0]
    }

    var body: some View {
        ZStack {
            WeatherBackground(condition: city.condition)

            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    header
                    currentConditions
                    hourlyForecast
                    details
                    actionButtons
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 32)
            }
        }
        .foregroundColor(.white)
        .sheet(isPresented: $showingWeekly) {
            WeeklyForecastView(city: city)
        }
        .sheet(isPresented: $showingCities) {
            SavedCitiesView(cities: cities, selectedCityID: city.id) { chosen in
                selectedCityID = chosen.id
            }
        }
    }

    // MARK: - Sections

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Image(systemName: "location.fill")
                        .font(.system(size: 14, weight: .semibold))
                    Text(city.name)
                        .font(.system(size: 26, weight: .bold, design: .rounded))
                }
                Text("\(city.country) · \(city.localTime)")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.75))
            }
            Spacer()
            Button {
                showingCities = true
            } label: {
                Image(systemName: "list.bullet")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Circle().fill(Color.white.opacity(0.2)))
            }
            .accessibilityLabel("Saved cities")
        }
    }

    private var currentConditions: some View {
        VStack(spacing: 4) {
            Image(systemName: city.condition.symbolName)
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 88))
                .frame(height: 110)
                .shadow(color: Color.black.opacity(0.15), radius: 10, x: 0, y: 6)

            Text("\(city.temperature)°")
                .font(.system(size: 104, weight: .thin, design: .rounded))
                .padding(.leading, 28)

            Text(city.condition.rawValue)
                .font(.system(size: 22, weight: .medium, design: .rounded))

            HStack(spacing: 14) {
                Label("H: \(city.high)°", systemImage: "arrow.up")
                Label("L: \(city.low)°", systemImage: "arrow.down")
            }
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.white.opacity(0.85))
            .padding(.top, 2)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }

    private var hourlyForecast: some View {
        GlassCard(title: "Hourly forecast", systemImage: "clock") {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(city.hourly) { hour in
                        HourlyCell(hour: hour, isNow: hour.id == city.hourly.first?.id)
                    }
                }
            }
        }
    }

    private var details: some View {
        LazyVGrid(columns: [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)], spacing: 12) {
            DetailTile(title: "Feels like", value: "\(city.feelsLike)°", systemImage: "thermometer")
            DetailTile(title: "Humidity", value: "\(city.humidity)%", systemImage: "drop.fill")
            DetailTile(title: "Wind", value: "\(city.windSpeed) km/h", systemImage: "wind")
            DetailTile(title: "UV index", value: uvDescription, systemImage: "sun.max")
        }
    }

    private var uvDescription: String {
        switch city.uvIndex {
        case 0...2: return "\(city.uvIndex) Low"
        case 3...5: return "\(city.uvIndex) Moderate"
        case 6...7: return "\(city.uvIndex) High"
        default: return "\(city.uvIndex) Very high"
        }
    }

    private var actionButtons: some View {
        VStack(spacing: 12) {
            HomeActionButton(title: "7-Day Forecast",
                             subtitle: "\(city.daily.count) days ahead",
                             systemImage: "calendar") {
                showingWeekly = true
            }
            HomeActionButton(title: "Saved Cities",
                             subtitle: "\(cities.count) locations",
                             systemImage: "building.2.fill") {
                showingCities = true
            }
        }
    }
}

// MARK: - Components

struct HourlyCell: View {
    let hour: HourlyForecast
    let isNow: Bool

    var body: some View {
        VStack(spacing: 8) {
            Text(hour.time)
                .font(.system(size: 14, weight: isNow ? .bold : .medium))
            Image(systemName: hour.condition.symbolName)
                .symbolRenderingMode(.multicolor)
                .font(.system(size: 24))
                .frame(height: 28)
            Text(hour.precipitationChance >= 20 ? "\(hour.precipitationChance)%" : " ")
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(Color(red: 0.62, green: 0.86, blue: 1.0))
            Text("\(hour.temperature)°")
                .font(.system(size: 18, weight: .semibold, design: .rounded))
        }
        .frame(width: 58)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.white.opacity(isNow ? 0.25 : 0.0))
        )
    }
}

struct DetailTile: View {
    let title: String
    let value: String
    let systemImage: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Label(title.uppercased(), systemImage: systemImage)
                .font(.caption.weight(.semibold))
                .foregroundColor(.white.opacity(0.7))
            Text(value)
                .font(.system(size: 22, weight: .semibold, design: .rounded))
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.white.opacity(0.16))
        )
    }
}

struct HomeActionButton: View {
    let title: String
    let subtitle: String
    let systemImage: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(systemName: systemImage)
                    .font(.system(size: 18, weight: .semibold))
                    .frame(width: 44, height: 44)
                    .background(
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(Color.white.opacity(0.22))
                    )
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 17, weight: .semibold))
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.75))
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white.opacity(0.7))
            }
            .foregroundColor(.white)
            .padding(14)
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.white.opacity(0.16))
            )
        }
        .buttonStyle(.plain)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
