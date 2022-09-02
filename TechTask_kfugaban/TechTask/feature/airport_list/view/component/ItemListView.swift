//
//  ItemListView.swift
//  TechTask
//
//  Created by kevin.fugaban on 8/26/22.
//

import SwiftUI

struct ItemListView: View {
    
    let airport: Airport
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading) {
                Text(airport.airportName)
                    .font(.headline)
                Text(airport.country.countryName)
                    .font(.system(size: 12))
            }
            NavigationLink(destination: AirportDetails(airport: airport)) {
                    EmptyView()
            }
        }
        .frame(maxWidth: .infinity,
               alignment: .leading)
        .padding()
        .background(Color.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding(.horizontal, 4)
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView(airport: .init(airportCode: "", internationalAirport: false, domesticAirport: false, regionalAirport: false, onlineIndicator: false, eticketableAirport: false, location: .init(aboveSeaLevel: 0, latitude: 0.0, latitudeRadius: 0.0, longitude: 0.0, longitudeRadius: 0.0, latitudeDirection: "", longitudeDirection: ""), airportName: "", city: .init(cityCode: "", cityName: "", timeZoneName: ""), country: .init(countryCode: "", countryName: "")))
    }
}
