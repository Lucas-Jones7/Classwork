// Lucas Jones & Henry Stickling

public class AnimalTree {
	private Node root;
	
	public AnimalTree() {
		this.root = null;
	}
	
	public void insert(int newValue, String newName) {
		if (root == null) {
			root = new Node(newValue, newName);
		}
		else {
			Node currentNode = root;
			boolean placed = false;
			while(!placed) {
				if(newValue < currentNode.getValue()){
					//Go left
					if (currentNode.getYes() == null) {
						currentNode.setYesChild(new Node(newValue, newName));
						currentNode.getYes().setParent(currentNode);
						placed = true;
					}
					else {
						currentNode = currentNode.getYes();
					}
				}
				else {
					// Go right
					if(currentNode.getNo() == null) {
						currentNode.setNoChild(new Node(newValue, newName));
						currentNode.getNo().setParent(currentNode);
						placed = true;
					}
					currentNode = currentNode.getNo();
								
				}
			}
		}
	}
	public void preOrder(Node n) {
		if (n!=null) {
			System.out.println(n.getValue());
			preOrder(n.getYes());
			preOrder(n.getNo());
		}
	}
	public void inOrder(Node n) {
		if (n!=null) {
			inOrder(n.getYes());
			System.out.println(n.getValue());
			inOrder(n.getNo());
		}
	}
	public void postOrder(Node n) {
		if (n!=null) {
			postOrder(n.getYes());
			postOrder(n.getNo());
			System.out.println(n.getValue());
		}
	}
	public Node getRoot() {
		return this.root;
	}
	public void setRoot(Node newNode) {
		this.root = newNode;
	}
}
