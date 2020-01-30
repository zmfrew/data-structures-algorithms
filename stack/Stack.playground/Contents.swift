var stack = Stack<Int>()
Array(1...10).map { stack.push($0) }
print(stack)

if let popped = stack.pop() {
    assert(10 == popped)
    print("Popped off: \(popped)")
}

let arr = Array(11...20)
let stack2 = Stack(arr)
print(stack2)


let stack3: Stack = ["stack", "a", "is", "this"]
print(stack3)


// ------------------------------------------------------------------------
// Challenge 1
// print linked list in reverse w/o recursion
var linkedList = LinkedList<Int>()
Array(1...10).forEach { linkedList.append($0) }
print(linkedList)
linkedList.reverse()
print(linkedList)
// Challenge 2
// check for balanced parentheses using stack
