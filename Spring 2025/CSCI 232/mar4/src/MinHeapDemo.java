
public class MinHeapDemo {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		MinHeap heap = new MinHeap();
		
		heap.add(10);
		heap.add(7);
		heap.add(15);
		heap.add(2);
		heap.add(42);
		heap.add(3);
		
		heap.printHeap();
		
		System.out.println(heap.poll());
		heap.printHeap();
	}

}
