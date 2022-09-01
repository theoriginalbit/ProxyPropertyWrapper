# ProxyPropertyWrapper

A property wrapper intended to reduce boilerplate of proxy properties.

## Motivation

Take the following example:
```swift
class HeaderView: UIView {
    private let titleLabel = UILabel()
}
```

In order to allow owning objects to set the `text` value of `titleLabel` it's common place for developers to go one of two implementations…

### The first implementation

Removing the `private` access modifier:
```swift
class HeaderView: UIView {
    let titleLabel = UILabel()
}
```

This approach is bad as it exposes implementation details—which should they change then bubbles around the rest of the code—and also exposes the label for other properties being set which could lead to bugs, unexpected behaviours, or confusion around appearance.

### The second implementation

An accessor/proxy property.

```swift
class HeaderView: UIView {
    private let titleLabel = UILabel()
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
}
```

In my experience those who know/understand the drawbacks of the first implementation will pick this approach instead.

This implementation doesn't have the same concern with exposing implementation details and also closes off the other properties for mutation, removing a large potential for bugs. The drawback this approach introduces is a large amount of boilerplate, with potential for typos especially copy/pasta typos. For example:

```swift
class HeaderView: UIView {
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    var title: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    var subtitle: String? {
        get { subtitleLabel.text }
        set { titleLabel.text = newValue } // 🛑 references titleLabel, should reference subtitleLabel
    }
}
```

### This library to the rescue

This is where this library comes in, using an accessor/proxy property like in the second implementation but without all the boilerplate.

```swift
class HeaderView: UIView {
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    @Proxy(\.titleLabel.text) var title
    @Proxy(\.subtitleLabel.text) var subtitle
}
```

As an added bonus we can also choose to omit the type information (`: String?`) from the property too, as the compiler can infer it from the key path, further reducing the boilerplate we must type.
