
public class Student {

	private String name;
	private String major;
	private int id; // key for hash table (unique)
	
	public Student(String n, String m, int i) {
		this.name = n;
		this.major = m;
		this.id = i;
	}
	
	public String getInfo() {
		return this.name + "(" + this.major + ")" + " ID: " + this.id;
	}
}
