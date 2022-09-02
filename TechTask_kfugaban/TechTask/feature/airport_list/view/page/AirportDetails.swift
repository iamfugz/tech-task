//
//  AirportDetails.swift
//  TechTask
//
//  Created by kevin.fugaban on 8/26/22.
//

import SwiftUI

struct AirportDetails: View {
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var airportViewModel = AirportViewModel(apiRequest: AirportApiRequest())
    let airport: Airport
    let screenSize = UIScreen.main.bounds
    
    var body: some View {
        
        NavigationView {
            ZStack {
                VStack{
                    VStack(spacing: 10){
                        Text("Currency: \(airportViewModel.getCurrencyCode(countryCode: airport.country.countryCode))")
                        Text("Timezone: \(airportViewModel.getTimeZone(timeZoneName: airport.city.timeZoneName ?? ""))")
                        Text("Location: \(airport.location.latitude ?? 0.0),\(airport.location.longitude ?? 0.0)")
                    }
                    Spacer()
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }){
                        Text("Back to list")
                            .foregroundColor(.white)
                    }
                    .frame(width: 120, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                }.padding(.bottom, 100)
            }
        }
        .navigationTitle("Details")
        .navigationBarBackButtonHidden(true)
            
        
    }
}

struct AirportDetails_Previews: PreviewProvider {
    static var previews: some View {
        AirportDetails(airport: .init(airportCode: "", internationalAirport: false, domesticAirport: false, regionalAirport: false, onlineIndicator: false, eticketableAirport: false, location: .init(aboveSeaLevel: 0, latitude: 0.0, latitudeRadius: 0.0, longitude: 0.0, longitudeRadius: 0.0, latitudeDirection: "", longitudeDirection: ""), airportName: "", city: .init(cityCode: "", cityName: "", timeZoneName: ""), country: .init(countryCode: "", countryName: "")))
    }
}
