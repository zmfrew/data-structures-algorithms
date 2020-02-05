var tree: BinaryNode<Int> = {
  let zero = BinaryNode(0)
  let one = BinaryNode(1)
  let five = BinaryNode(5)
  let seven = BinaryNode(7)
  let eight = BinaryNode(8)
  let nine = BinaryNode(9)
  
  seven.leftChild = one
  one.leftChild = zero
  one.rightChild = five
  seven.rightChild = nine
  nine.leftChild = eight
  
  return seven
}()

print(tree)
tree.traverseInOrder { print($0) }
print("---------------------\n")
tree.traversePreOrder { print($0) }
print("---------------------\n")
tree.traversePostOrder { print($0) }
