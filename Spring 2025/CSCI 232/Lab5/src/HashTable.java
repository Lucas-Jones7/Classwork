import java.util.Random;

public class HashTable {

	// You are welcome to make changes to this class, but you should not remove any of the existing code.

	private Integer[] data;
	private String[] collisions;
	
	public HashTable(int size) {
		this.data = new Integer[size]; 
		this.collisions = new String[size];
		for(int i = 0; i < collisions.length; i++) {
			collisions[i] = "";
		}
	}
	
	public int hash(int i) {
		return i % data.length;
	}
	
	public void insert(int newEntry) {
		//TO DO: Lab 6
		//Must use linear probing to handle collisions
		int index = hash(newEntry);
		int ogIndex = index;
		while (data[index] != null) {
			collisions[index] += "*";
			index = (index + 1) % data.length;
			if (index == ogIndex) {
				break;
			}
		}
		
		data[index] = newEntry;
		
	}

	public void printHashTable() {
		//TO DO: Lab 6
		for(int i = 0; i < data.length; i++) {
			if(data[i] != null) {
				System.out.println(i + ": " + data[i]);
			} else {
				System.out.println(i + ": ");
			}
		}
	}

	public void insertRandomValues(int n) {
		//TO DO: Lab 6
		Random rand = new Random();
		for (int i = 0; i < n; i++) {
			int randomnum = rand.nextInt(1001);
			insert(randomnum);
		}
	}


	public void printCollisionTable() {
		//TO DO: Lab 6
		for (int i = 0; i < collisions.length; i++) {
			if(!collisions[i].isEmpty()) {
				System.out.println(i + ": " + collisions[i]);
			} else {
				System.out.println(i + ": ");
			}
		}
	}
		

	public int get(int search) {
		//TO DO: Lab 6
		int index = hash(search);
		int startIndex = index;
		
		while (data[index] != null) {
			if (data[index].equals(search)) {
				return index;
			}
			index = (index + 1) % data.length;
			if (index == startIndex) {
				break;
			}
		}
		
		return -1;
	}

}