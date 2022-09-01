@testable import ProxyPropertyWrapper
import XCTest

final class MutableProxyTests: XCTestCase {
    func testProxyGet() {
        let view = TestView()
        XCTAssertEqual(view.text, "Initial value")
    }

    func testProxySet() {
        let view = TestView()
        XCTAssertEqual(view.text, "Initial value")
        view.text = "New value"
        XCTAssertEqual(view.text, "New value")
    }
}

private final class TestView: UIView {
    private let label = UILabel()

    @Proxy(\.label.text) var text

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = "Initial value"
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
