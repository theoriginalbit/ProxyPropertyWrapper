#if canImport(UIKit)
import UIKit

extension UIView: ProxyContainer {}
#endif

#if canImport(AppKit)
import AppKit

extension NSView: ProxyContainer {}
#endif
