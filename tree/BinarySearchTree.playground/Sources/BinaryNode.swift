import Foundation

public class BinaryNode<Element> {
    public var value: Element
    public var leftChild: BinaryNode?
    public var rightChild: BinaryNode?
    
    public init(_ value: Element) {
        self.value = value
    }
}

extension BinaryNode: CustomStringConvertible {
    public var description: String { diagram(for: self) }
    
    private func diagram(for node: BinaryNode?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        guard let node = node else { return root + "nil\n" }
        
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value)\n"
        }
        
        return diagram(for: node.rightChild,
                           top + " ", top + "┌──", top + "│ ")
                 + root + "\(node.value)\n"
                 + diagram(for: node.leftChild,
                           bottom + "│ ", bottom + "└──", bottom + " ")
    }
}

extension BinaryNode {
    public func traverseInOrder(visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
}

extension BinaryNode {
    public func traversePreOrder(visit: (Element) -> Void) {
        visit(value)
        leftChild?.traverseInOrder(visit: visit)
        rightChild?.traverseInOrder(visit: visit)
    }
    
    // Challenge 2 - serialize the tree into an array & deserialize back into tree
    public func traversePreOrderWithNil(visit: (Element?) -> Void) {
        visit(value)
        if let leftChild = leftChild {
            leftChild.traversePreOrderWithNil(visit: visit)
        } else {
            visit(nil)
        }
        
        if let rightChild = rightChild {
            rightChild.traversePreOrderWithNil(visit: visit)
        } else {
            visit(nil)
        }
    }
}

internal extension BinaryNode {
    var min: BinaryNode { leftChild?.min ?? self }
}

extension BinaryNode {
    public func traversePostOrder(visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        rightChild?.traverseInOrder(visit: visit)
        visit(value)
    }
}

// Challenge 1 - find the height of the tree
public func height<T>(of node: BinaryNode<T>?) -> Int {
    guard let node = node else { return -1 }
    
    return 1 + max(height(of: node.leftChild), height(of: node.rightChild))
}

// Challenge 2 - serialize the tree into an array & deserialize back into tree
public func serialize<T>(_ node: BinaryNode<T>) -> [T?] {
    var array = [T?]()
    node.traversePreOrderWithNil { array.append($0) }
    return array
}
// Challenge 2 - serialize the tree into an array & deserialize back into tree
public func deserialize<T>(_ array: inout [T?]) -> BinaryNode<T>? {
    guard let value = array.removeLast() else { return nil }
    
    let node = BinaryNode(value)
    node.leftChild = deserialize(&array)
    node.rightChild = deserialize(&array)
    return node
}
