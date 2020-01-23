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
    public mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        copyNodes()
        
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
        copyNodes()
        
        head = head?.next
        
        if isEmpty {
            tail = nil
        }
        
        return head?.value
    }
    
    public mutating func push(_ value: Value) {
        copyNodes()
        
        head = Node(next: head, value: value)
        
        if tail == nil {
            tail = head
        }
    }
    
    @discardableResult
    public mutating func remove(after node: Node<Value>) -> Value? {
        copyNodes()
        
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
        copyNodes()
        
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

extension LinkedList: Collection {
    public var endIndex: Index {
        return Index(node: tail?.next)
    }
    
    
    public var startIndex: Index {
        return Index(node: head)
    }
    
    public subscript(position: Index) -> Value {
        return position.node!.value
    }
    
    public func index(after i: Index) -> Index {
        return Index(node: i.node?.next)
    }
    
    public struct Index: Comparable {
        public var node: Node<Value>?
        
        public static func ==(lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left.next === right.next
            case (nil, nil):
                return true
            default:
                return false
            }
        }
        
        public static func <(lhs: Index, rhs:Index) -> Bool {
            guard lhs != rhs else { return false }
            
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains { $0 === rhs.node }
        }
    }
}
