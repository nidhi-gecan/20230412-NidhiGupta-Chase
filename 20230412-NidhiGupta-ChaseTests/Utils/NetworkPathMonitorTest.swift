// XCTest for NetworkPathMonitor class
import XCTest
@testable import _0230412_NidhiGupta_Chase

class NetworkPathMonitorTest: XCTestCase {

    func testNetworkPathMonitor() {
        let networkPathMonitor = NetworkPathMonitor()
        XCTAssertEqual(networkPathMonitor.networkPathMonitor?.pathUpdateHandler as? NetworkPathMonitor, networkPathMonitor)
    }

    func testNetworkPathMonitorPathUpdateHandler() {
        let networkPathMonitor = NetworkPathMonitor()
        let path = NWPath()
        networkPathMonitor.networkPathMonitor?(NWPathMonitor(), didUpdate: path)
        XCTAssertEqual(networkPathMonitor.path, path)
    }

    func testNetworkPathMonitorCancel() {
        let networkPathMonitor = NetworkPathMonitor()
        networkPathMonitor.cancel()
        XCTAssertNil(networkPathMonitor.networkPathMonitor)
    }
}
