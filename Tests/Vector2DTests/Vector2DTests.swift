import XCTest
@testable import Vector2D

final class Vector2DTests: XCTestCase {
    
    /// test `point.as(CGSize.self)`
    func testPointAsSize() {
        let p = CGPoint(1, 2)
        let s = CGSize(1, 2)
        XCTAssertEqual(p.as(CGSize.self), s)
    }
    
    /// test `CGSize(point)`
    func testSizeInitWithPoint() {
        let s1 = CGSize(1, 2)
        let s2 = CGSize(CGPoint(1, 2))
        XCTAssertEqual(s1, s2)
    }
}
