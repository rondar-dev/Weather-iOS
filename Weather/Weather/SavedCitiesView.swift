//
//  SavedCitiesView.swift
//  Weather
//
//  The saved cities screen. Tapping a city shows it on the home screen.
//

import SwiftUI

struct SavedCitiesView: View {
    @Binding var selectedCity: CityWeather
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                ForEach(SampleWeather.cities) { city in
                    Button {
                        selectedCity = city
                        dismiss()
                    } label: {
                        SavedCityCard(city: city, isSelected: city.name == selectedCity.name)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(16)
        }
        .background(Color(red: 0.07, green: 0.09, blue: 0.16).ignoresSafeArea())
        .navigationTitle("Saved Cities")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SavedCityCard: View {
    let city: CityWeather
    let isSelected: Bool

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Text(city.name)
                        .font(.title3.weight(.bold))
                    if isSelected {
                        Image(systemName: "location.fill")
                            .font(.caption)
                    }
                }
                Text(city.localTime)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.white.opacity(0.8))
                Spacer(minLength: 12)
                HStack(spacing: 6) {
                    Image(systemName: city.condition.symbolName)
                        .foregroundStyle(city.condition.iconColor)
                    Text(city.condition.rawValue)
                }
                .font(.subheadline.weight(.medium))
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 4) {
                Text("\(city.temperature)°")
                    .font(.system(size: 48, weight: .light))
                Spacer(minLength: 0)
                Text("H:\(city.high)°  L:\(city.low)°")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.white.opacity(0.85))
            }
        }
        .foregroundStyle(.white)
        .padding(16)
        .frame(height: 124)
        .background(
            LinearGradient(colors: city.condition.gradient, startPoint: .topLeading, endPoint: .bottomTrailing),
            in: RoundedRectangle(cornerRadius: 22, style: .continuous)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(.white.opacity(isSelected ? 0.8 : 0.0), lineWidth: 2)
        )
    }
}

struct SavedCitiesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SavedCitiesView(selectedCity: .constant(SampleWeather.sanFrancisco))
        }
    }
}
