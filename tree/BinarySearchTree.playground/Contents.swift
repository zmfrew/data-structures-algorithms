var unbalancedBst = BinarySearchTree<Int>()
for i in 0..<5 {
    unbalancedBst.insert(i)
}
print(unbalancedBst)

print("-----------------------------------------------\n")

var bst = BinarySearchTree<Int>()
bst.insert(3)
bst.insert(1)
bst.insert(4)
bst.insert(0)
bst.insert(2)
bst.insert(5)
print(bst)

print("-----------------------------------------------\n")

print("\(bst.contains(5) == true ? "Found 5!" : "Didn't find 5")")

print("-----------------------------------------------\n")

bst.remove(3)
print(bst)
