import java.util.LinkedList;
import java.util.Queue;

public class BST {

	private Node root;
	
	public BST() {
		this.root = null;
	}
	
	public void insert(int newValue) {
		
		if(root == null) {
			root = new Node(newValue);
		}
		else {
			
			Node currentNode = root;
			boolean placed = false;
			
			while(!placed) {
				
				if(currentNode.getValue() == newValue) {
					placed = true;
					System.out.println("No duplicate values allowed");
				}
				else if(newValue < currentNode.getValue()) {
					//move left
					if(currentNode.getLeft() == null) {
						// cant move left, so we found insertion spot
						//insert Node
						currentNode.setLeft(new Node(newValue));
						currentNode.getLeft().setParent(currentNode);
						placed = true;
					}
					else {
						// otherwise move left
						currentNode = currentNode.getLeft();
					}
				}
				else {
					//move right
					if(currentNode.getRight() == null) {
						//cant move right, insert new node
						currentNode.setRight(new Node(newValue));
						currentNode.getRight().setParent(currentNode);
						placed = true;
					}
					else {
						//move right
						currentNode = currentNode.getRight();
					}
				}	
			}		
		}	
	}
	
	public Node getRoot() {
		return this.root;
	}
	
	
	//These are the four methods you need to write for lab 4. You are welcome to make additional changes to the BST class.
	int counter = 1;
	public void inOrder(Node n) {
		//TO DO: Lab 3
		if (n != null) {
			inOrder(n.getLeft());
			System.out.println(counter + ". " + n.getValue());
			counter += 1;
			inOrder(n.getRight());
		}

	}

	public void breadthFirst() {
		//TO DO: Lab 3
		if(root == null) return;
		
		Queue<Node> queue = new LinkedList<>();
		queue.add(root);
		int count = 1;
		
		while (!queue.isEmpty()) {
			Node current = queue.poll();
			System.out.println(count + ". " + current.getValue());
			count++;
			
			if (current.getLeft() != null) { 
				queue.add(current.getLeft());
			}
			if (current.getRight() != null) {
				queue.add(current.getRight());
			}
		}
		
	}

	
	public int getMin() {
		//TO DO: Lab 3
		if (root == null) return -1;
		
		Node current = root;
		while (current.getLeft() != null) {
			current = current.getLeft();
		}
		return current.getValue();
	}
	public int getMax() {
		//TO DO: Lab 3
		if (root == null) return -1;
		
		Node current = root;
		while (current.getRight() != null) {
			current = current.getRight();
		}
		return current.getValue();
	}
	
	public Node find(int value) {
		//TO DO: Lab 3
		Node current = root;
		while(current != null) {
			if(current.getValue() == value) {
				System.out.println("Found!");
				return current;
			}
			else if(value < current.getValue()) {
				current = current.getLeft();
			}
			else {
				current = current.getRight();
			}
		}
		System.out.println("Not found");
		return null;
	}
	

	
}