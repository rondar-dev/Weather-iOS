//
//  ContentView.swift
//  Weather
//
//  Created by Anup Harbade on 2/24/22.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedCity: CityWeather = SampleWeather.sanFrancisco

    var body: some View {
        NavigationStack {
            ZStack {
                WeatherBackground(condition: selectedCity.condition)

                ScrollView {
                    VStack(spacing: 20) {
                        CurrentWeatherHeader(city: selectedCity)
                        HourlyForecastRow(hourly: selectedCity.hourly)
                        NavigationButtons(selectedCity: $selectedCity)
                        WeatherDetailsGrid(city: selectedCity)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
        .tint(.white)
    }
}

struct CurrentWeatherHeader: View {
    let city: CityWeather

    var body: some View {
        VStack(spacing: 6) {
            Label("My Location", systemImage: "location.fill")
                .font(.caption.weight(.semibold))
                .foregroundStyle(.white.opacity(0.8))

            Text(city.name)
                .font(.system(size: 34, weight: .semibold))
                .foregroundStyle(.white)

            Text("\(city.country) · \(city.localTime)")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.75))

            Image(systemName: city.condition.symbolName)
                .font(.system(size: 72))
                .foregroundStyle(city.condition.iconColor)
                .shadow(color: .black.opacity(0.15), radius: 8, y: 4)
                .padding(.top, 12)

            Text("\(city.temperature)°")
                .font(.system(size: 96, weight: .thin))
                .foregroundStyle(.white)

            Text(city.condition.rawValue)
                .font(.title3.weight(.medium))
                .foregroundStyle(.white.opacity(0.9))

            HStack(spacing: 16) {
                Text("H: \(city.high)°")
                Text("L: \(city.low)°")
                Text("Feels like \(city.feelsLike)°")
            }
            .font(.subheadline.weight(.medium))
            .foregroundStyle(.white.opacity(0.85))
        }
        .padding(.top, 16)
        .padding(.bottom, 8)
    }
}

struct HourlyForecastRow: View {
    let hourly: [HourlyForecast]

    var body: some View {
        WeatherCard(title: "Hourly Forecast", systemImage: "clock") {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(hourly) { hour in
                        VStack(spacing: 8) {
                            Text(hour.time)
                                .font(.subheadline.weight(hour.time == "Now" ? .bold : .medium))
                            Image(systemName: hour.condition.symbolName)
                                .font(.title2)
                                .foregroundStyle(hour.condition.iconColor)
                                .frame(height: 30)
                            Text(hour.precipitationChance > 0 ? "\(hour.precipitationChance)%" : " ")
                                .font(.caption2.weight(.semibold))
                                .foregroundStyle(Color(red: 0.6, green: 0.85, blue: 1.0))
                            Text("\(hour.temperature)°")
                                .font(.title3.weight(.semibold))
                        }
                        .foregroundStyle(.white)
                        .frame(width: 58)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .fill(.white.opacity(hour.time == "Now" ? 0.22 : 0.0))
                        )
                    }
                }
            }
        }
    }
}

struct NavigationButtons: View {
    @Binding var selectedCity: CityWeather

    var body: some View {
        HStack(spacing: 12) {
            NavigationLink {
                ForecastView(city: selectedCity)
            } label: {
                NavigationButtonLabel(title: "7-Day Forecast", systemImage: "calendar")
            }

            NavigationLink {
                SavedCitiesView(selectedCity: $selectedCity)
            } label: {
                NavigationButtonLabel(title: "Saved Cities", systemImage: "list.star")
            }
        }
    }
}

struct NavigationButtonLabel: View {
    let title: String
    let systemImage: String

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: systemImage)
                .font(.headline)
            Text(title)
                .font(.subheadline.weight(.semibold))
            Spacer(minLength: 0)
            Image(systemName: "chevron.right")
                .font(.caption.weight(.bold))
                .foregroundStyle(.white.opacity(0.6))
        }
        .foregroundStyle(.white)
        .padding(.horizontal, 14)
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
        .background(.white.opacity(0.2), in: RoundedRectangle(cornerRadius: 16, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(.white.opacity(0.3), lineWidth: 1)
        )
    }
}

struct WeatherDetailsGrid: View {
    let city: CityWeather

    private let columns = [GridItem(.flexible(), spacing: 12), GridItem(.flexible(), spacing: 12)]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            DetailTile(title: "Humidity", systemImage: "humidity.fill", value: "\(city.humidity)%")
            DetailTile(title: "Wind", systemImage: "wind", value: "\(city.windSpeed) km/h")
            DetailTile(title: "UV Index", systemImage: "sun.max", value: "\(city.uvIndex)")
            DetailTile(title: "Visibility", systemImage: "eye.fill", value: "\(city.visibility) km")
        }
    }
}

struct DetailTile: View {
    let title: String
    let systemImage: String
    let value: String

    var body: some View {
        WeatherCard(title: title, systemImage: systemImage) {
            Text(value)
                .font(.title.weight(.semibold))
                .foregroundStyle(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
