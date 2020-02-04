import Foundation

public class TreeNode<T> {
    public var value: T
    public var children = [TreeNode]()
    
    public init(_ value: T) {
        self.value = value
    }
    
    public func add(_ child: TreeNode) {
        children.append(child)
    }
}

extension TreeNode {
    public func forEachDepthFirst(visit: (TreeNode) -> Void) {
        visit(self)
        children.forEach {
            $0.forEachDepthFirst(visit: visit)
        }
    }
}

extension TreeNode {
    public func forEachLevelOrder(visit: (TreeNode) -> Void) {
        visit(self)
        var queue = Queue<TreeNode>()
        children.forEach { queue.enqueue($0) }
        while let node = queue.dequeue() {
            visit(node)
            node.children.forEach { queue.enqueue($0) }
        }
    }
}

extension TreeNode where T: Equatable {
    public func search(_ value: T) -> TreeNode? {
        var result: TreeNode?
        forEachLevelOrder { node in
            if node.value == value {
                result = node
            }
        }
        
        return result
    }
}


// Challenge 1: print tree values in order of level
/* i.e.
 15
 1 17 20
 1 5 0 2 5 7
 */

extension TreeNode {
    public func prettyPrint(_ node: TreeNode<T>) {
        var queue = Queue<TreeNode<T>>()
        var nodesInLevel = 0
        queue.enqueue(node)
        
        while !queue.isEmpty {
            nodesInLevel = queue.count
            
            while nodesInLevel > 0 {
                guard let node = queue.dequeue() else { break }
                
                print("\(node.value)", terminator: " ")
                node.children.forEach { queue.enqueue($0) }
                
                nodesInLevel -= 1
            }
            
            print()
        }
    }
}
