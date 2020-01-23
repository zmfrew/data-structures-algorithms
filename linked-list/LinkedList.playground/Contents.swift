let node1 = Node(value: 1)
let node2 = Node(value: 2)
let node3 = Node(value: 3)

node1.next = node2
node2.next = node3

print(node1)


var list = LinkedList<Int>()
list.push(3)
list.push(2)
list.push(1)

print("Before inserting: \(list)")
var middleNode = list.node(at: 1)!

for i in 1...4 {
    middleNode = list.insert(i, after: middleNode)
}
print("After inserting: \(list)")


print("Before popping list: \(list)")
let popped = list.pop()
print("After popping list: \(list)")
print("Popped off: " + String(describing: popped))


print("Before removing last node: \(list)")
let removed = list.removeLast()
print("After removing last node: \(list)")
print("Removed value: " + String(describing: removed))


print("Before removing at a particular index: \(list)")
let index = 1
let node = list.node(at: index - 1)!
let removedValue = list.remove(after: node)
print("after removing at a particular index: \(list)")
print("Removed value: " + String(describing: removedValue))


print("List: \(list)")
print("First element: \(list[list.startIndex])")
print("Array containing first 3 elements: \(Array(list.prefix(3)))")
print("Array containing last 3 elements: \(Array(list.suffix(3)))")

let sum = list.reduce(0, +)
print("Sum of all values: \(sum)")


var list1 = LinkedList<Int>()
list1.append(1)
list1.append(2)
var list2 = list1
print("List1: \(list1)")
print("List2: \(list2)")

print("After appending 3 to list2")
list2.append(3)
print("List1: \(list1)")
print("List2: \(list2)")
