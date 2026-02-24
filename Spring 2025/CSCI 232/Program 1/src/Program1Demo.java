import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

// Lucas Jones & Henry Stickling

public class Program1Demo {

	public static void main(String[] args) {
		
		AnimalTree tree = new AnimalTree();
		File file = new File("tree.txt");
		Scanner scanner = null;
		try {
			scanner = new Scanner(file);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		while (scanner.hasNextLine()) {
			String information = scanner.nextLine().trim();
			String[] split = information.split(",");
			try {
			
			int num = Integer.parseInt(split[0].trim());
			String name = split[1].trim();
			tree.insert(num, name);
			
			} catch (NumberFormatException e) {
				continue;
				
			}
		}
		
		scanner.close();
		Inputs animalGame = new Inputs(tree);
		animalGame.promptIdentification();
		
	}


}
