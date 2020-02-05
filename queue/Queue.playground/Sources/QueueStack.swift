import Foundation

public struct QueueStack<T> {
    public typealias Element = T
    
    private var stack = Stack<T>()
    private var tempStack = Stack<T>()
    
    public var isEmpty: Bool { stack.isEmpty }
    public var peek: T? { stack.peek() }
    
    public init() { }
    
    public mutating func enqueue(_ element: T) -> Bool {
        stack.push(element)
        return true
    }
    
    public mutating func dequeue() -> T? {
        while let value = stack.pop() {
            tempStack.push(value)
        }
        
        let returnValue = tempStack.pop()
        
        while let value = tempStack.pop() {
            stack.push(value)
        }
        
        return returnValue
    }
}

extension QueueStack: CustomStringConvertible {
    public var description: String {
        guard !self.stack.isEmpty else { return "Empty queue" }
        var stack = self.stack
        var tempStack = self.tempStack
        
        var description = ""
        
        while let value = stack.pop() {
            tempStack.push(value)
        }
        
        while let value = tempStack.pop() {
            stack.push(value)
            description += "\(value)" + " "
        }
        
        return description
    }
}
