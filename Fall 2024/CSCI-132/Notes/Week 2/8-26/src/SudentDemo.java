
public class SudentDemo {

	public static void main(String[] args) {
		
		aug26 student1 = new aug26("Jank Boteko", 3.18, "Computer Science: Professional");
		aug26 student2 = new aug26("John Pork", 1.20, "Gooning");
		
		System.out.println(student1.getName());
		System.out.println(student1.getGPA());
		System.out.println(student1.getMajor());
		
		//student1.setMajor("Business");
		//System.out.println(student1.getMajor());
		
		student1.checkForProbation();
		
		System.out.println(student2.getName());
		System.out.println(student2.getGPA());
		System.out.println(student2.getMajor());
		
		student2.checkForProbation();
	}

}
