import Foundation

public protocol Applicable {}

public extension Applicable where Self: AnyObject {
    func apply(_ closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: Applicable {}

public extension Applicable {
    func apply(_ closure: (inout Self) -> Void) -> Self {
        var copy = self
        closure(&copy)
        return copy
    }
}
