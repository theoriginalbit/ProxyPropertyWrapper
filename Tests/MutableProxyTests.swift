@testable import ProxyPropertyWrapper
import Testing

@Suite struct MutableProxyTests {
    private let object = ProxyTestObject(label: "The initial value")
    
    @Test func testMutableProxyObtainsValue() {
        #expect(object.label == "The initial value")
    }
    
    @Test func testMutableProxyMutatesValue() {
        #expect(object.label == "The initial value")
        object.label = "New value"
        #expect(object.label == "New value")
    }
    
    @Test func testMutableProxyReadsExternallyMutatedValue() {
        #expect(object.label == "The initial value")
        object.value.label = "New value"
        #expect(object.label == "New value")
    }
}
