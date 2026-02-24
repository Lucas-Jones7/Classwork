
public class HashTableDemo {
	
	public static void main(String[] args) {
		
		StudentHashTable database = new StudentHashTable(100);
		
		database.insert("Joe", "Computer Science", 245006);//Example student for insertion into Hash table
		database.insert("Susan", "Math", 123456);
		database.insert("Marcus", "Biology", 245666);
		database.insert("Mr. Collision", "chaos", 111156); // Intentional case of a collision
		Student findME = database.lookup(245006); //method that looks for the key asscosiated with the id #
		System.out.println();
		//System.out.println(findME.getInfo()); // prints out students ID #
		
		database.print();
		System.out.println();
		database.remove(123456);
		database.print();
	}
}
