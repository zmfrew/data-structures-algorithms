import Foundation

public struct LinkedList<Value> {
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public init() { }
    
    public var isEmpty: Bool { head == nil }
    
    public mutating func append(_ value: Value) {
        copyNodes()
        
        guard !isEmpty else {
            push(value)
            return
        }
        
        tail!.next = Node(value: value)
        tail = tail!.next
    }
    
    private mutating func copyNodes() {
        guard !isKnownUniquelyReferenced(&head) else { return }
        
        guard var oldNode = head else { return }
        
        head = Node(value: oldNode.value)
        var newNode = head
        
        while let nextOldNode = oldNode.next {
            newNode!.next = Node(value: nextOldNode.value)
            newNode = newNode!.next
            
            oldNode = nextOldNode
        }
        
        tail = newNode
    }
    
    @discardableResult
    public mutating func pop() -> Value? {
        defer {
            head = head?.next
            
            if isEmpty {
                tail = nil
            }
        }
        copyNodes()
        
        return head?.value
    }
    
    public mutating func push(_ value: Value) {
        copyNodes()
        
        head = Node(next: head, value: value)
        
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func reverse() {
        copyNodes()
        
        var stack = Stack<Value>()
        
        while let value = pop() {
            stack.push(value)
        }
        
        while let value = stack.pop() {
            append(value)
        }
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else { return "Empty list" }
        
        return String(describing: head)
    }
}
