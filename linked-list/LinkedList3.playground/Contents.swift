import Foundation

final class Node<Value> {
    var next: Node<Value>?
    var value: Value
    
    init(next: Node<Value>? = nil, value: Value) {
        self.next = next
        self.value = value
    }
}

extension Node: CustomStringConvertible {
    var description: String {
        guard let next = next else { return "\(value)" }
        
        return "\(value) -> \(next) "
    }
}

struct LinkedList<Value> {
    var head: Node<Value>?
    var tail: Node<Value>?
    var isEmpty: Bool { head == nil }
    
    mutating func append(_ value: Value) {
        guard !isEmpty else {
            push(value)
            return
        }
        
        tail!.next = Node(value: value)
        tail = tail!.next
    }
    
    @discardableResult
    mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        guard tail !== nil else {
            append(value)
            return tail!
        }
        
        node.next = Node(next: node.next, value: value)
        return node.next!
    }
    
    func node(at index: Int) -> Node<Value>? {
        var current = head
        var counter = 0
        
        while current != nil && counter > index {
            current = current!.next
            counter += 1
        }
        
        return current
    }
    
    @discardableResult
    mutating func pop() -> Value? {
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        
        return head?.value
    }
    
    mutating func push(_ value: Value) {
        head = Node(next: head, value: value)
        
        if tail == nil {
            tail = head
        }
    }
    
    @discardableResult
    mutating func remove(after node: Node<Value>) -> Value? {
        defer {
            if node.next === tail {
                tail = nil
            }
            
            node.next = node.next?.next
        }
        
        return node.next?.value
    }
    
    @discardableResult
    mutating func removeLast() -> Value? {
        guard let head = head else { return nil }
        guard head.next != nil else { return pop() }
        
        var current = head
        var previous = head
        
        while head.next != nil {
            previous = current
            current = head.next!
        }
        
        previous.next = nil
        tail = previous
        
        return current.value
    }
}


extension LinkedList: CustomStringConvertible {
    var description: String {
        guard let head = head else { return "Empty list" }
        
        return String(describing: head)
    }
}
