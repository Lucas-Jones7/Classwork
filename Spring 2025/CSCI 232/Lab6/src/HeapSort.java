import java.lang.reflect.Array;

public class HeapSort implements HeapSortMethods{
	private int[] array;

	public HeapSort(int[] array) {
		// TODO Auto-generated constructor stub
		this.array = array;
	}
	
	public int[] heapSort() {
		buildHeap();
		
		for(int i = array.length- 1; i > 0; i--) {
			swap(0, i);
			heapifyDown(i, 0);
		}
		return array;
	}
	
	public void buildHeap() {
		int start_index = (array.length / 2) - 1;
		for (int i = start_index; i >= 0; i--) {
			heapifyDown(array.length, i);
		}
	}
	
	public void heapifyDown(int bound, int current){
		int largest_child = current;
		int left_child_index = 2 * current + 1;
		int right_child_index = 2 * current + 2;
		
		if(left_child_index < bound && array[left_child_index] > array[largest_child]) {
			largest_child = left_child_index;
		}
		
		if(right_child_index < bound && array[right_child_index] > array[largest_child]) {
			largest_child = right_child_index;
		}
		
		if(largest_child != current) {
			swap(current, largest_child);
			heapifyDown(bound, largest_child);
		}
	}
	
	public void swap(int indexOne, int indexTwo) {
		int temp = array[indexOne];
		array[indexOne] = array[indexTwo];
		array[indexTwo] = temp;
	}
		
} 