import Foundation

public struct BinarySearchTree<Element: Comparable> {
    public private(set) var root: BinaryNode<Element>?
    
    public init() { }
}

extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        guard let root = root else { return "Empty tree" }
        return String(describing: root)
    }
}

extension BinarySearchTree {
    public mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }
    
    private func insert(from node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element> {
        guard let node = node else { return BinaryNode(value) }
        
        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        
        return node
    }
}

extension BinarySearchTree {
    public func contains(_ value: Element) -> Bool {
        var current = root
        
        while let node = current {
            if node.value == value {
                return true
            }
            
            if value < node.value {
                current = node.leftChild
            } else {
                current = node.rightChild
            }
        }
        
        return false
    }
    
    public func slowContains(_ value: Element) -> Bool {
        guard let root = root else { return false }
        
        var found = false
        root.traverseInOrder {
            if $0 == value {
                found = true
            }
        }
        
        return found
    }
}

extension BinarySearchTree {
    public mutating func remove(_ value: Element) {
        root = remove(node: root, value: value)
    }
    
    private func remove(node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element>? {
        guard let node = node else { return nil }
        
        if value == node.value {
            if node.leftChild == nil && node.rightChild == nil {
                return nil
            }
            
            if node.leftChild == nil {
                return node.rightChild
            }
            
            if node.rightChild == nil {
                return node.leftChild
            }
            
            node.value = node.rightChild!.min.value
            node.rightChild = remove(node: node.rightChild, value: node.value)
        } else if value < node.value {
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
        
        return node
    }
}

// BST Challenge 1 - create a function to check if a binary tree is a bst.
extension BinaryNode where Element: Comparable {
    var isBinarySearchTree: Bool { isBST(self, min: nil, max: nil) }
    
    private func isBST(_ node: BinaryNode<Element>?, min: Element?, max: Element?) -> Bool {
        guard let node = node else { return true }
        
        if let min = min, node.value <= min {
            return false
        } else if let max = max, node.value > max {
            return false
        }
        
        return isBST(node.leftChild, min: min, max: node.value) && isBST(node.rightChild, min: node.value, max: max)
    }
}

// BST Challenge 2 - conform to Equatable.
extension BinarySearchTree: Equatable {
    public static func == (lhs: BinarySearchTree, rhs: BinarySearchTree) -> Bool {
        return isEqual(lhs.root, rhs.root)
    }
    
    private static func isEqual<Element: Equatable>(_ node1: BinaryNode<Element>?, _ node2: BinaryNode<Element>?) -> Bool {
        guard let left = node1, let right = node2 else {
            return node1 == nil && node2 == nil
        }
        
        return left.value == right.value &&
            isEqual(left.leftChild, right.leftChild) &&
            isEqual(left.rightChild, right.rightChild)
    }
}

// BST Challenge 3 - check if current tree contains all elements of another tree.
extension BinarySearchTree where Element: Hashable {
    public func contains(_ subtree: BinarySearchTree) -> Bool {
        var set: Set<Element> = []
        root?.traverseInOrder { set.insert($0) }
        
        var isEqual = true
        
        subtree.root?.traverseInOrder {
            isEqual = isEqual && set.contains($0)
        }
        
        return isEqual
    }
}
