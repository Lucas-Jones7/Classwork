
public class HashTableDemo {
	
	public static void main(String[] args) {
		
		StudentHashTable database = new StudentHashTable(100);
		
		database.insert("Joe", "Computer Science", 245006);//Example student for insertion into Hash table
		database.insert("Susan", "Math", 777777);
		database.insert("broooo", "Computer Science", 444444);
		database.insert("stank", "Computer Science", 333333);
		database.insert("hank", "History", 222222);
		database.insert("mike", "Chemistry", 111111);
		database.insert("Jack", "Biology", 123456);
		database.insert("Mr. Collision", "chaos", 111156); // Intentional case of a collision with jacks id # 
		Student findME = database.lookup(245006); //method that looks for the key asscosiated with the id #
		System.out.println();
		System.out.println(findME.getInfo()); // prints out students ID #
		
		database.print();
		System.out.println();
		database.remove(777777);
		database.print();
		System.out.println();
	}
}
