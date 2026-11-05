//
//  SavedCitiesView.swift
//  Weather
//
//  List of saved cities; choosing one shows it on the home screen.
//

import SwiftUI

struct SavedCitiesView: View {
    let cities: [CityWeather]
    let selectedCityID: UUID
    let onSelect: (CityWeather) -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color(red: 0.10, green: 0.14, blue: 0.30),
                                    Color(red: 0.20, green: 0.28, blue: 0.52)],
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                SheetHeader(title: "Saved Cities", subtitle: "\(cities.count) locations") {
                    dismiss()
                }

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(cities) { city in
                            Button {
                                onSelect(city)
                                dismiss()
                            } label: {
                                CityCard(city: city, isSelected: city.id == selectedCityID)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                }
            }
        }
        .foregroundColor(.white)
    }
}

struct CityCard: View {
    let city: CityWeather
    let isSelected: Bool

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Text(city.name)
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                    if isSelected {
                        Image(systemName: "location.fill")
                            .font(.system(size: 12, weight: .semibold))
                    }
                }
                Text(city.localTime)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.8))
                Spacer(minLength: 8)
                HStack(spacing: 6) {
                    Image(systemName: city.condition.symbolName)
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 16))
                    Text(city.condition.rawValue)
                        .font(.system(size: 14, weight: .medium))
                }
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(city.temperature)°")
                    .font(.system(size: 46, weight: .light, design: .rounded))
                Spacer(minLength: 8)
                Text("H:\(city.high)°  L:\(city.low)°")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.85))
            }
        }
        .padding(16)
        .frame(height: 120)
        .background(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(LinearGradient(colors: city.condition.gradient, startPoint: .topLeading, endPoint: .bottomTrailing))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(Color.white.opacity(isSelected ? 0.9 : 0.0), lineWidth: 2)
        )
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 4)
    }
}

struct SavedCitiesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedCitiesView(cities: CityWeather.sampleCities,
                        selectedCityID: CityWeather.sampleCities[0].id) { _ in }
    }
}
