/// A property wrapper that acts as a proxy between two properties within the containing type.
///
/// It can accept any `KeyPath` defined on the same type this property wrapper is used, including
/// nested properties, as long as the property is mutable and defined on a reference type (class).
///
/// ```swift
/// class SomeType {
///     var value: String?
/// }
///
/// class DataStorage {
///     private let someContainer = SomeType()
///
///     @MutableProxy(\DataStorage.someContainer.value) var value
/// }
/// ```
/// - Note: The compiler can infer the type of `value` to be `String?` from the supplied
/// `KeyPath`.
///
/// It is recommended you conform your type to ``MutableProxyContainer`` to use a more
/// concise syntax and further reduce boilerplate. Conforming to the ``MutableProxyContainer``
/// protocol enables you to define the previous code like so
///
/// ```swift
/// class SomeType {
///     var value: String?
/// }
///
/// class DataStorage: MutableProxyContainer {
///     private let someContainer = SomeType()
///
///     @Proxy(\.someContainer.value) var value
/// }
/// ```
///
/// - Important: This library adds ``MutableProxyContainer`` conformance to `UIView` and `NSView`.
@propertyWrapper public struct MutableProxy<EnclosingType, Value> {
    public typealias PropertyKeyPath = ReferenceWritableKeyPath
    
    @available(*, unavailable, message: "@MutableProxy can only function inside a class")
    public var wrappedValue: Value {
        get { fatalError("only works on instance properties of classes") }
        set { fatalError("only works on instance properties of classes") }
    }
    
    private let keyPath: PropertyKeyPath<EnclosingType, Value>
    
    public init(_ keyPath: PropertyKeyPath<EnclosingType, Value>) {
        self.keyPath = keyPath
    }
    
    public static subscript<OuterSelf>(
        _enclosingInstance instance: OuterSelf,
        wrapped wrappedKeyPath: PropertyKeyPath<OuterSelf, Value>,
        storage storageKeyPath: PropertyKeyPath<OuterSelf, MutableProxy<OuterSelf, Value>>
    ) -> Value {
        get {
            let keyPath = instance[keyPath: storageKeyPath].keyPath
            return instance[keyPath: keyPath]
        }
        set {
            let keyPath = instance[keyPath: storageKeyPath].keyPath
            instance[keyPath: keyPath] = newValue
        }
    }
}
