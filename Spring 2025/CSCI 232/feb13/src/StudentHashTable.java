import java.util.HashMap;
import java.util.HashSet;


public class StudentHashTable {
	
	private HashMap<Integer, Student> database;
	private HashSet<Integer> keySpace;
	
	public StudentHashTable(int size) {
		this.database = new HashMap<Integer, Student>();
		this.keySpace = new HashSet<>();
	}
	
	public void insert(String newName, String newMajor, int newID) {
		Student newStudent = new Student(newName, newMajor, newID); //creates new student object with arguments for name, mahor, and ID #
		//int arrayIndex = hash(newID);
		if(database.get(newID) == null) {
			database.put(newID, newStudent); //Inserts new student and arrayIndex value
			keySpace.add(newID);
		}
		else {
			System.out.println("Collision detected");
		}
	}
	
	
	public Student lookup(int id) {
		return database.get(id);
	}
	
	public void remove(int id) {
		database.remove((Integer)id); //removes the current index from database
		keySpace.remove((Integer)id); //removes the keySpace linked to the same index just removed from the database
	}
	
	public void print() {
		
		for(int id: keySpace) { // for each id in the keyspace
			System.out.println(database.get(id).getInfo());
			
		// THE LESS EFFICIENT WAY	
		// for(int i = 0; i < database.length; i++) {
			// if(database[i] != null) {
				// System.out.println(database[i].getInfo());
			//}
		}
	}
}
