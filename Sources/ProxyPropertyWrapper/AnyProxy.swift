/// A property wrapper that acts as a proxy between two properties within the containing type.
///
/// It can accept any key path defined on the same type this property wrapper is used, including
/// nested properties.
///
/// ```
/// class HeaderView: UIView {
///     private let titleLabel = UILabel()
///
///     @AnyProxy(\HeaderView.titleLabel.text) var titleText
/// }
/// ```
///
/// In the above example `titleText` will have the type `String?` which the compiler
/// can automatically infer from the key path. It is a two way proxy, allowing callers to use
/// both the get and set the proxied property.
///
/// It is recommended you conform your type to ``ProxyContainer`` to use a more
/// concise syntax with key paths and further reduce boilerplate. `UIView` already conforms
/// to the protocol. Conforming to the `ProxyContainer` protocol enables you to define
/// the previous code like so
///
/// ```
/// class HeaderView: UIView {
///     private let titleLabel = UILabel()
///
///     @Proxy(\.titleLabel.text) var titleText
/// }
/// ```
///
@propertyWrapper public struct AnyProxy<EnclosingType, Value> {
    public typealias WrappedKeyPath = ReferenceWritableKeyPath<EnclosingType, Value>

    @available(*, unavailable)
    public var wrappedValue: Value {
        get { fatalError("only works on instance properties of classes") }
        set { fatalError("only works on instance properties of classes") }
    }

    private let keyPath: WrappedKeyPath

    public init(_ keyPath: WrappedKeyPath) {
        self.keyPath = keyPath
    }

    public static subscript<OuterSelf>(
        _enclosingInstance instance: OuterSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<OuterSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<OuterSelf, AnyProxy<OuterSelf, Value>>
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
