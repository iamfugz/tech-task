//
//  ContentView.swift
//  TechTask
//
//  Created by kevin.fugaban on 8/26/22.
//

import SwiftUI

struct AirportList: View {

    @StateObject private var airportViewModel = AirportViewModel(apiRequest: AirportApiRequest())
    @StateObject private var networkManager = NetworkManager()
    
    var body: some View {
        NavigationView {
            ZStack {
                if airportViewModel.isLoading {
                    ProgressView()
                }else {
                    if airportViewModel.hasError && airportViewModel.airports.isEmpty{
                        VStack{
                            Text(airportViewModel.errorMessage)
                                .foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                                .padding(.all)
                
                            Button(action: {
                                Task {
                                    await airportViewModel.getAirports(isNetworkConnected: networkManager.isNetworkConnected)
                                }
                            }){
                                Text("Retry")
                            }
                        }
                    } else {
                        VStack{
                            if airportViewModel.hasError{
                                HStack{
                                    Text(airportViewModel.errorMessage)
                                        .foregroundColor(/*@START_MENU_TOKEN@*/.gray/*@END_MENU_TOKEN@*/)
                                        .padding(.all)
                        
                                    Button(action: {
                                        print(networkManager.isNetworkConnected)
                                        Task {
                                            await airportViewModel.getAirports(isNetworkConnected: networkManager.isNetworkConnected)
                                        }
                                    }){
                                        Text("Retry")
                                    }
                                }
                            }
                            
                            List(airportViewModel.airports, id: \.airportCode) {
                                 airport in
                                    ItemListView(airport: airport)
                                        .listRowSeparator(.hidden)
                            }
                            .refreshable {
                                Task {
                                    await airportViewModel.getAirports(isNetworkConnected: networkManager.isNetworkConnected)
                                }
                            }
                            .listStyle(.plain)
                            .navigationBarTitle("Airports", displayMode: .inline)
                        }
                    }
                }
            }
            .task {
                if(airportViewModel.airports.isEmpty){
                    await airportViewModel.getAirports(isNetworkConnected: networkManager.isNetworkConnected)
                }
            }
        }
        .navigationViewStyle(.stack)
        
    }
}

struct AirportList_Previews: PreviewProvider {
    static var previews: some View {
        AirportList()
    }
}
