import ProxyPropertyWrapper

final class ProxyTestObject: ProxyContainer {
    final class NestedObject {
        var label: String
        var count: Int
        
        init(label: String, count: Int) {
            self.label = label
            self.count = count
        }
    }
    
    let value: NestedObject
    
    @SetProxy(\.value.label) var label
    @GetProxy(\.value.count) var count
    
    init(label: String = "Initial value", count: Int = 0) {
        value = NestedObject(label: label, count: count)
    }
}
