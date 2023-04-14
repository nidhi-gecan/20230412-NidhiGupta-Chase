// XCTest for the ImageCache class
import XCTest
@testable import _0230412_NidhiGupta_Chase

class ImageCacheTest: XCTestCase {

    func testDownloadImage() {
        let imageCache = ImageCache.shared
        let url = URL(string: "https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png")!
        imageCache.downloadImage(url: url, icon: "google") { (image) in
            XCTAssertNotNil(image)
        }
    }

}
