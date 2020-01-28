import Foundation

public struct Stack<Element> {
    private var storage = [Element]()
    
    public var isEmpty: Bool { peek() == nil }
    
    public init() { }
    
    public init(_ elements: [Element]) { storage = elements }
    
    public mutating func push(_ element: Element) { storage.append(element) }
    
    public func peek() -> Element? { storage.last }
    
    @discardableResult
    public mutating func pop() -> Element? { storage.popLast() }
}

extension Stack: CustomStringConvertible {
    public var description: String {
        let topDivider = "----top----\n"
        let bottomDivider = "\n-----------"
        
        let stackElements = storage.map({ "\($0)" }).reversed().joined(separator: "\n")
        
        return topDivider + stackElements + bottomDivider
    }
}

extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
}
