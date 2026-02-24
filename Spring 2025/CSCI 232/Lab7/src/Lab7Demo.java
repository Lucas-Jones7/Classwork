import java.util.ArrayList;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Random;
import java.util.TreeSet;

public class Lab7Demo {
	
	public static void main(String[] args) {
		
		Random random = new Random();
		int num_elements = 100000;
		
		//ArrayList
		ArrayList<Integer> arraylist = new ArrayList<>();
		long start_time = System.nanoTime();
		for (int i = 0; i < num_elements; i++) {
			arraylist.add(random.nextInt());
		}
		long end_time = System.nanoTime();
		long elapsed_time = (end_time - start_time);
		double milliseconds = elapsed_time / 1000000.0;
		System.out.println("ArrayList time: " + milliseconds + "ms.");
		
		//LinkedList
		LinkedList<Integer> linkedlist = new LinkedList<>();
		start_time = System.nanoTime();
		for (int i = 0; i < num_elements; i++) {
			linkedlist.add(random.nextInt());
		}
		end_time = System.nanoTime();
		elapsed_time = (end_time - start_time);
		milliseconds = elapsed_time / 1000000.0;
		System.out.println("LinkedList time: " + milliseconds + "ms.");
		
		//TreeSet
		TreeSet<Integer> treeset = new TreeSet<>();
		start_time = System.nanoTime();
		for (int i = 0; i < num_elements; i++) {
			treeset.add(random.nextInt());
		}
		end_time = System.nanoTime();
		elapsed_time = (end_time - start_time);
		milliseconds = elapsed_time / 1000000.0;
		System.out.println("TreeSet time: " + milliseconds + "ms.");
		
		//HashSet
		HashSet<Integer> hashset = new HashSet<>(150000);
		start_time = System.nanoTime();
		for (int i = 0; i < num_elements; i++) {
			hashset.add(random.nextInt());
		}
		end_time = System.nanoTime();
		elapsed_time = (end_time - start_time);
		milliseconds = elapsed_time / 1000000.0;
		System.out.println("HashSet time: " + milliseconds + "ms.");
		
	}
}
