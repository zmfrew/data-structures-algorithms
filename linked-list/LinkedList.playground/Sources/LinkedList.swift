import Foundation

public struct LinkedList<Value: Comparable> {
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
    
    public static func merge(_ list1: LinkedList<Value>, _ list2: LinkedList<Value>) -> LinkedList<Value>? {
        guard !list1.isEmpty, !list2.isEmpty else { return nil }
        
        var longer = list1.count > list2.count ? list1 : list2
        var shorter = list1.count > list2.count ? list2 : list1
        
        while let value = shorter.pop() {
            var placed = false
            var current = longer.head!
            var previous = longer.head!
            
            while value > current.value {
                if current.next == nil {
                    longer.append(value)
                    placed = true
                    break
                }
                
                previous = current
                current = current.next!
            }
            
            if !placed {
                if value == current.value {
                    longer.push(value)
                    continue
                }
                
                longer.insert(value, after: previous)
            }
        }
        
        return longer
    }
    
    public func middle() -> Node<Value>? {
        var slow = head
        var fast = head
        
        while fast != nil && fast?.next != nil {
            slow = slow?.next
            fast = fast?.next?.next
        }
        
        return slow
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
    
    @discardableResult
    public mutating func removeOccurrences(of element: Value) {
        var previous = head
        var current = head?.next
        while let currentNode = current {
            guard currentNode.value != element else {
                previous?.next = currentNode.next
                current = previous?.next
                continue
            }
            
            previous = current
            current = current?.next
        }
        
        tail = previous
    }
    
    public func printReversed(_ node: Node<Value>?) {
        guard let node = node else { return }
        printReversed(node.next)
    }
    
    public mutating func reverse() {
        copyNodes()
        
        var list = LinkedList<Value>()
        for i in self {
            list.push(i)
        }
        
        head = list.head
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
