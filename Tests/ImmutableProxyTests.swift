@testable import ProxyPropertyWrapper
import Testing

@Suite struct ImmutableProxyTests {
    @Test func testImmutableProxyObtainsValue() {
        let count = Int.random(in: 0...100)
        let object = ProxyTestObject(count: count)
        #expect(object.count == count)
    }
}
