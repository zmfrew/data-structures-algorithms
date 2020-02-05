var queueArr = QueueArray<String>()
queueArr.dequeue()
queueArr.enqueue("Me")
queueArr.enqueue("Myself")
queueArr.enqueue("I")
queueArr
queueArr.dequeue()
queueArr
queueArr.peek

var queueStack = QueueStack<Int>()
queueStack.dequeue()
queueStack.enqueue(0)
queueStack.enqueue(8)
queueStack.enqueue(7)
queueStack.enqueue(22)
queueStack.enqueue(42)
print(queueStack)
queueStack.dequeue()
queueStack.peek
queueStack.isEmpty
print(queueStack)
queueStack.dequeue()
print(queueStack)
