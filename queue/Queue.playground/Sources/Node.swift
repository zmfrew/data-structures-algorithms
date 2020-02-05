public final class Node<Value> {
    public var next: Node?
    public var value: Value
    
    public init(next: Node? = nil, value: Value) {
        self.next = next
        self.value = value
    }
}

extension Node: CustomStringConvertible {
    public var description: String {
        guard let next = next else { return "\(value)" }
        
        return "\(value) => " + String(describing: next) + " "
    }
}
