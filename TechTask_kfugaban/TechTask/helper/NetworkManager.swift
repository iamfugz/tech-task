//
//  NetworkManager.swift
//  TechTask
//
//  Created by kevin.fugaban on 8/28/22.
//

import Foundation
import Network

class NetworkManager: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "NetworkManager")
    @Published var isNetworkConnected = false
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isNetworkConnected = path.status == .satisfied
            }
        }
        
        monitor.start(queue: queue)
    }
}
