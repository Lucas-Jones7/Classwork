import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.LinkedList;
import java.util.Queue;
import java.util.Scanner;

//Lucas Jones & Henry Stickling

public class Inputs {
	
	private AnimalTree tree;
	private int currentMaxValue;
	
	public Inputs(AnimalTree tree) {
		this.tree = tree;
		this.currentMaxValue = findMaxValue(tree.getRoot());
	}
	
    private int findMaxValue(Node node) {
        if (node == null) {
            return -1;  // Base case: no node, return -1
        }
        
        // Find the maximum value in the left and right subtrees
        int leftMax = findMaxValue(node.getYes());
        int rightMax = findMaxValue(node.getNo());
        
        // Return the maximum of the current node's value and the max value in subtrees
        return Math.max(node.getValue(), Math.max(leftMax, rightMax));
    }
	
	public void promptIdentification() {
		
		boolean looper = true;
		Scanner scanner = new Scanner(System.in);

		
		while(looper) {
			
			System.out.println("Do you have another animal to identify? (Y/N) > ");
			String pwd = "";
			String answer = scanner.nextLine().trim().toLowerCase();
			
			Node currentNode = tree.getRoot();
			if (answer.equals("n")) {
				System.out.println("Goodbye!");
				looper = false;
			} else if (answer.equals("y")) {
				
				while (!currentNode.isAnimal()) {
					
					System.out.println("Is this animal " + currentNode.getName() + "? (Y/N) ");
					String answer2 = scanner.nextLine().trim().toLowerCase();
					
					if(answer2.equals("y")) {
						pwd += currentNode.getName() + " ";
						currentNode = currentNode.getYes();
					}
					else if(answer2.equals("n")) {
						pwd += "Not " + currentNode.getName() + " ";
						currentNode = currentNode.getNo();
					}
					else{
						System.out.println("Please enter y or n for (yes/no)");
					}		
				}	
			
				System.out.println("Hmmm... I think I know.");
				System.out.println("Is it a " + currentNode.getName() + "? (Y/N) ");
				String answer3 = scanner.nextLine().trim().toLowerCase();
			
				if (answer3.equals("y")) {
				System.out.println("Good! All done.");
				}
				else if (answer3.equals("n")) {
					
					System.out.println("I was wrong...");
					System.out.println("I don't know any animals that are " + pwd);
					System.out.println("What is the new animal? > ");
					String animalName = scanner.nextLine().trim();
					System.out.println("What characteristic does " + animalName + " have that a " + currentNode.getName() + " does not? > ");
					String characteristicName = scanner.nextLine().trim();
					
                    int newValue = ++currentMaxValue; 
                    Node newQuestionNode = new Node(newValue, characteristicName);
                    newValue = ++currentMaxValue;  
                    Node newAnimalNode = new Node(newValue, animalName);
					
					insertNode(currentNode, newQuestionNode, newAnimalNode);
					
                }
                saveTreeToFile("tree.txt");
            }
            else {
                System.out.println("Please enter y or n for (yes/no)");
            }   
        }
        scanner.close();
    }

    
	private void insertNode(Node currentNode, Node newQuestionNode, Node newAnimalNode) {
	    
	    if (currentNode.getParent() == null) {
	        tree.setRoot(newQuestionNode);
	        newQuestionNode.setYesChild(newAnimalNode);
	        newQuestionNode.setNoChild(currentNode);
	        newAnimalNode.setParent(newQuestionNode);
	        currentNode.setParent(newQuestionNode);
	    } else {
	        
	        Node parent = currentNode.getParent();
	        if (newQuestionNode.getValue() < parent.getValue()) {
	            parent.setYesChild(newQuestionNode);
	        } else {
	            parent.setNoChild(newQuestionNode);
	        }
	        newQuestionNode.setYesChild(newAnimalNode);
	        newQuestionNode.setNoChild(currentNode);
	        newAnimalNode.setParent(newQuestionNode);
	        currentNode.setParent(newQuestionNode);
	    }
	}
	
	private void relabelTree(Node node) {
	    if (node == null) {
	        return;
	    }
	    relabelTree(node.getYes()); 
	    node.setValue(++currentMaxValue);  
	    relabelTree(node.getNo());   
	}

	private void saveTreeToFile(String filename) {
	   
	    relabelTree(tree.getRoot());

	    Queue<Node> queue = new LinkedList<>();

	    try (BufferedWriter writer = new BufferedWriter(new FileWriter(filename))) {
	        Node root = tree.getRoot();
	        if (root != null) {
	            queue.add(root);

	            while (!queue.isEmpty()) {
	                Node node = queue.remove();

	                writer.write(node.getValue() + "," + node.getName());
	                writer.newLine();

	                if (node.getYes() != null) {
	                    queue.add(node.getYes());
	                }
	                if (node.getNo() != null) {
	                    queue.add(node.getNo());
	                }
	            }
	        } else {
	            System.out.println("The tree is empty. Nothing to save.");
	        }
	    } catch (IOException e) {
	        System.out.println("Error writing to file: " + e.getMessage());
	    }
	}
}
