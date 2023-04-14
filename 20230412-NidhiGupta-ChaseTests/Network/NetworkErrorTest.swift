// XCTest for the NetworkError class
import XCTest
@testable import _0230412_NidhiGupta_Chase

class NetworkErrorTest: XCTestCase {

    func testServerError() {
        let error = NetworkError.serverError(statusCode: 404)
        XCTAssertEqual(error.description, "Server Error: 404")
    }
    
    func testNotFound() {
        let error = NetworkError.notFound(message: "City not found")
        XCTAssertEqual(error.description, "City not found")
    }
    
    func testDecodingError() {
        let error = NetworkError.decodingError(error: NSError(domain: "Decoding Error", code: 0, userInfo: nil))
        XCTAssertEqual(error.description, "Decoding Error: Error Domain=Decoding Error Code=0 \"(null)\"")
    }
    
    func testUnexpected() {
        let error = NetworkError.unexpected(error: NSError(domain: "Unexpected Error", code: 0, userInfo: nil))
        print(error.localizedDescription)
        XCTAssertEqual(error.localizedDescription, "The operation couldn’t be completed. (_0230412_NidhiGupta_Chase.NetworkError error 3.)")
    }
}
