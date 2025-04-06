/// A convenience type which defines a type alias to provide `Self` as the first generic parameter.
///
/// Conforming your types to this protocol allows you to use the `@Proxy` short-hand instead of
/// `@MutableProxy` by providing `Self` as the first generic parameter and allowing your key
/// paths at the usage site to not require supplying seemingly redundant type information.
///
/// - Note: There is also a `@SetProxy` short-hand which pairs well with `@GetProxy` defined
/// by ``ImmutableProxyContainer``.
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
/// This library makes `UIView` and `NSView` conform to this protocol, so any of your subclass you can
/// straight away use `@Proxy`.
public protocol MutableProxyContainer {
    typealias Proxy<T> = MutableProxy<Self, T>
    
    typealias SetProxy<T> = Proxy<T>
}
