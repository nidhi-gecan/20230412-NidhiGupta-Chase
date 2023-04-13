//
//  NetworkPathMonitor.swift
//  20230412-NidhiGupta-Chase
//
//  Created by Nidhi Gupta on 12/04/23.
//

import Network

class NetworkPathMonitor {
    static let shared = NetworkPathMonitor()

//    let monitor = NWPathMonitor()
    
    let monitor: NWPathMonitor
    
    private var status: NWPath.Status = .requiresConnection
//    var isReachable: Bool { status == .satisfied }
    private (set) var isReachable: Bool
    var isReachableOnCellular: Bool = true

    private init(monitor: NWPathMonitor = NWPathMonitor()){
        self.monitor = monitor
        self.isReachable = false
        startMonitoring()
    }
    
    deinit{
        stopMonitoring()
        print("deinit")
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive

            if path.status == .satisfied {
                self?.isReachable = true
                print("We're connected!")
                // post connected notification
            } else {
                self?.isReachable = false
                print("No connection.")
                // post disconnected notification
            }
//            print(path.isExpensive)
        }

        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
}
