
public class aug26 {
	
	private String name;
	private double gpa;
	private String major;
	
	public aug26(String inName, double inGPA, String inMajor) {
		this.name = inName;
		this.gpa = inGPA;
		this.major = inMajor;
	}
	
	public String getName() {
		return this.name;
	}

	public double getGPA() {
		return this.gpa;
	}
	
	public String getMajor() {
		return this.major;
	}
	
	public void setMajor(String newMajor) {
		this.major = newMajor;
	}
	
	public void checkForProbation() {
		if(this.gpa <= 2.0) {
			System.out.println("Student: " + this.name + " is on probation");
		}
		else {
			System.out.println("Student: " + this.name + " is in good standing");
		}
	}
}
