import UIKit

/// A convenience type which defines a type alias to provide `Self` as the first generic parameter.
///
/// Conforming your types to this protocol allows you to use the preferred `@Proxy` instead of
/// `@AnyProxy`. These type aliases supply `Self` as the first generic parameter allowing your
/// key paths at the usage site to not require supplying seemingly redundant type information.
///
/// ```
/// class HeaderView: UIView {
///     private let titleLabel = UILabel()
///
///     @Proxy(\.titleLabel.text) var titleText
/// }
/// ```
///
/// This library makes `UIView` and `NSView` conform to this protocol, so any of your subclass you can
/// straight away use `@Proxy` and `@GetterProxy`.
public protocol ProxyContainer {
    typealias Proxy<T> = AnyProxy<Self, T>
}

extension UIView: ProxyContainer {}
