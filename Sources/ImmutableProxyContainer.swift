/// A convenience type which defines a typealias to provide `Self` as the first generic parameter.
///
/// Conforming your types to this protocol allows you to use the `@ReadOnlyProxy` short-hand
/// instead of `@ImmutableProxy` by providing `Self` as the first generic parameter and allowing
/// your key paths at the usage site to not require supplying seemingly redundant type information.
///
/// - Note: There is also a `@GetProxy` short-hand which pairs well with `@SetProxy` defined
/// by ``MutableProxyContainer``.
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
/// This library makes `UIView` and `NSView` conform to this protocol, so any of your subclass you can
/// straight away use `@ReadOnlyProxy`.
public protocol ImmutableProxyContainer {
    typealias ReadOnlyProxy<T> = ImmutableProxy<Self, T>
    
    typealias GetProxy<T> = ImmutableProxy<Self, T>
}
