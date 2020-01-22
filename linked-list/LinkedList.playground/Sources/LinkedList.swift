import Foundation

public struct LinkedList<Value> {
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() { }
    
    public var isEmpty: Bool { head == nil }
    
    public mutating func append(_ value: Value) {
        guard !isEmpty else {
            push(value)
            return
        }
        
        tail!.next = Node(value: value)
        tail = tail!.next
    }
    
    @discardableResult
    public mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        node.next = Node(next: node.next, value: value)
        return node.next!
    }
    
    public func node(at index: Int) -> Node<Value>? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    @discardableResult
    public mutating func pop() -> Value? {
        head = head?.next
        
        if isEmpty {
            tail = nil
        }
        
        return head?.value
    }
    
    public mutating func push(_ value: Value) {
        head = Node(next: head, value: value)
        
        if tail == nil {
            tail = head
        }
    }
    
    @discardableResult
    public mutating func remove(after node: Node<Value>) -> Value? {
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        
        return node.next?.value
        
    }
    
    @discardableResult
    public mutating func removeLast() -> Value? {
        guard let head = head else { return nil }
        
        guard head.next != nil else { return pop() }
        
        var current = head
        var previous = head
        while let next = current.next {
            previous = current
            current = next
        }
        
        previous.next = nil
        tail = previous
        
        return current.value
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else { return "Empty list" }
        
        return String(describing: head)
    }
}
