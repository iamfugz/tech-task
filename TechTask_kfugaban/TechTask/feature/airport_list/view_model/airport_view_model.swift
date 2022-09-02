//
//  airport_view_model.swift
//  TechTask
//
//  Created by kevin.fugaban on 8/26/22.
//

import Foundation

final class AirportViewModel: ObservableObject {
    
    @Published var airports: [Airport] = []
    @Published var hasError = false
    @Published var errorMessage = ""
    @Published private(set) var isLoading = false
    
    var apiRequest: AirportApiProtocol!
    
    init(apiRequest: AirportApiProtocol){
        self.apiRequest = apiRequest
    }
    
    
    func getAirports(isNetworkConnected: Bool) async{
        self.isLoading = true
        self.hasError = false
        
        if(!isNetworkConnected){
            self.isLoading = false
            self.hasError = true
            self.errorMessage = getErrorMessage(error: ErrorType.noNetwork)
            return
        }
        
        guard let url = URL(string: "https://api.qantas.com/flight/refData/airport") else{
            self.isLoading = false
            self.hasError = true
            self.errorMessage = getErrorMessage(error: ErrorType.failedApi)
            return
        }
        
        do {
            let apiResponse: [Airport] = try await apiRequest.fetch(url: url)
            
            DispatchQueue.main.async {
                self.airports = apiResponse
                self.isLoading = false
            }
        } catch {
            DispatchQueue.main.async {
                self.isLoading = false
                self.hasError = true
                self.errorMessage = self.getErrorMessage(error: ErrorType.failedApi)
            }
        }
    }
    
    func getCurrencyCode(countryCode: String) -> String {
        let localeIdentifier = Locale.identifier(fromComponents: [NSLocale.Key.countryCode.rawValue: countryCode])
        let locale = Locale(identifier: localeIdentifier)
        
        return locale.currencyCode ?? ""
    }
    
    func getTimeZone(timeZoneName: String) -> String {
        let timeZoneIdentifier = TimeZone(identifier: timeZoneName)
        let timeZoneAbbr = timeZoneIdentifier?.abbreviation()
        
        return timeZoneAbbr ?? ""
    }
    
    private func getErrorMessage(error: ErrorType) -> String{
        switch error {
        case ErrorType.failedApi:
               return "Failed to load data."
        case ErrorType.noNetwork:
               return "No network connection."}
    }
}

enum ErrorType {
  case failedApi, noNetwork
}
