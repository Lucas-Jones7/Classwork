import java.util.LinkedList;

public class StudentHashTable {
	
	private Student[] database;
	private LinkedList<Integer> keySpace;
	
	public StudentHashTable(int size) {
		this.database = new Student[size];
		this.keySpace = new LinkedList<>();
	}
	
	public void insert(String newName, String newMajor, int newID) {
		Student newStudent = new Student(newName, newMajor, newID); //creates new student object with arguments for name, mahor, and ID #
		int arrayIndex = hash(newID);
		if(database[arrayIndex] == null) {
			database[arrayIndex] = newStudent; //Inserts new student and arrayIndex value
			keySpace.add(newID);
		}
		else {
			System.out.println("Collision detected");
		}
	}
	
	public int hash(int id) {
		return id % database.length; // could be 100 but database.length allows for dynamic resizing of array
	}
	
	public Student lookup(int id) {
		int index = hash(id);
		return database[index];
	}
	
	public void remove(int id) {
		int index = hash(id);
		database[index] = null; //removes the current index from database
		keySpace.remove((Integer)id); //removes the keySpace linked to the same index just removed from the database
	}
	
	public void print() {
		
		for(int id: keySpace) { // for each id in the keyspace
			int index = hash(id);
			System.out.println(index + ": " + database[index].getInfo());
			
		// THE LESS EFFICIENT WAY	
		// for(int i = 0; i < database.length; i++) {
			// if(database[i] != null) {
				// System.out.println(database[i].getInfo());
			//}
		}
	}
}
