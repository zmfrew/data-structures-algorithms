import Foundation

public struct QueueArray<T>: Queue {
    public typealias Element = T
    
    private var array = [T]()
    public var isEmpty: Bool { array.isEmpty }
    public var peek: T? { array.first }
    
    public init() { }
    
    public mutating func dequeue() -> T? {
        array.isEmpty ? nil : array.removeFirst()
    }
    
    public mutating func enqueue(_ element: T) -> Bool {
        array.append(element)
        return true
    }
}

extension QueueArray: CustomStringConvertible {
    public var description: String { String(describing: array) }
}
