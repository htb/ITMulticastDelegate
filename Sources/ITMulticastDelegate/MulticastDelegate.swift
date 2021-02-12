import Foundation


public class MulticastDelegate<P>
{
    private var _weakDelegates = [WeakWrapper]()

    public init() { }

    public var count: Int
    {
        // Use the opportunity to remove all dangling weak pointers
        _weakDelegates.removeAll(where: { $0.value == nil })
        return _weakDelegates.count
    }

    @discardableResult
    public func add(_ delegate: P) -> Bool
    {
        if _weakDelegates.first(where: { $0.value === (delegate as AnyObject) }) != nil {
            return false  // not added
        }
        _weakDelegates.append(WeakWrapper(value: delegate as AnyObject))
        return true  // was added
    }

    public func remove(_ delegate: P)
    {
        // Also remove all dangling weak pointers
        _weakDelegates.removeAll(where: { $0.value == nil || $0.value === (delegate as AnyObject) })
    }

    public func invoke(invocation: (P) -> ())
    {
        // Clean up dangling delegates
        _weakDelegates.removeAll(where: { $0.value == nil })

        let currentDelegates = _weakDelegates
        currentDelegates.forEach {
            if let delegate = $0.value as? P { invocation(delegate) }
        }
    }
}

extension MulticastDelegate: Sequence
{
    public func makeIterator() -> Array<P>.Iterator
    {
        return _weakDelegates.filter { $0.value != nil }.map { $0 as! P }.makeIterator()
    }
}


public func += <P> (left: MulticastDelegate<P>, right: P) { left.add(right) }
public func -= <P> (left: MulticastDelegate<P>, right: P) { left.remove(right) }


private class WeakWrapper
{
    weak var value: AnyObject?

    init(value: AnyObject) {
        self.value = value
    }
}
