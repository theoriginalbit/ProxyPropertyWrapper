/// A property wrapper that acts as a read-only proxy between two properties within the containing type.
///
/// It can accept any `KeyPath` defined on the same type this property wrapper is used, including
/// nested properties, as long as the property is defined on a reference type (class). The referenced
/// property may be mutable, but the proxy will prevent the property from being set.
///
/// - Note: The compiler requires that property wrappers be applied to a 'var', so the ``ImmutableProxy``
/// property wrapper marks its `set` modifier as unavailable, you _may_ add `private(set)` to the
/// property if you wish, though it is not required.
///
/// The following code snippet is an example usage of this property wrapper.
/// ```swift
/// class SomeType {
///     var value: String?
/// }
///
/// class DataStorage {
///     private let someContainer = SomeType()
///
///     @ImmutableProxy(\DataStorage.someContainer.value) var value
/// }
/// ```
/// - Note: The compiler can infer the type of `value` to be `String?` from the supplied
/// `KeyPath`.
///
/// It is recommended you conform your type to ``ImmutableProxyContainer`` to use a more
/// concise syntax and further reduce boilerplate. Conforming to the ``ImmutableProxyContainer``
/// protocol enables you to define the previous code like so
///
/// ```swift
/// class SomeType {
///     var value: String? // could also be a 'let' property
/// }
///
/// class DataStorage: ImmutableProxyContainer {
///     private let someContainer = SomeType()
///
///     @ReadOnlyProxy(\.someContainer.value) var value
/// }
/// ```
///
/// - Important: This library adds ``ImmutableProxyContainer`` conformance to `UIView` and `NSView`.
@propertyWrapper public struct ImmutableProxy<EnclosingType, Value> {
    public typealias PropertyKeyPath = KeyPath
    
    @available(*, unavailable, message: "@ImmutableProxy can only function inside a class")
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
        storage storageKeyPath: PropertyKeyPath<OuterSelf, ImmutableProxy<OuterSelf, Value>>
    ) -> Value {
        get {
            let keyPath = instance[keyPath: storageKeyPath].keyPath
            return instance[keyPath: keyPath]
        }
        @available(*, unavailable, message: "setter is inaccessible") set {
            fatalError("set unavailable on immutable proxy")
        }
    }
}
