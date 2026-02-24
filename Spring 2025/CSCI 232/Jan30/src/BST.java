
public class BST {

	private Node root;
	
	public BST() {
		this.root = null;
	}
	
	public Node getRoot() {
		return this.root;
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
					System.out.println("NO duplicate Values allowed");
					placed = true;
				}
				else if(newValue < currentNode.getValue()) {
					// GO LEFT
					if(currentNode.getLeft() == null) {
						currentNode.setLeft(new Node(newValue));
						currentNode.getLeft().setParent(currentNode);
						placed = true;
					}
					else {
						currentNode = currentNode.getLeft();
					}
				}
				else {
					if(currentNode.getRight() == null) {
						currentNode.setRight(new Node(newValue));
						currentNode.getRight().setParent(currentNode);
						placed = true;
					}
					else {
						currentNode = currentNode.getRight();
					}
				}
			}
			
		}
	}
	public void depthFirst(Node n) {
		if( n != null) {
			System.out.println(n.getValue());
			depthFirst(n.getLeft());
			depthFirst(n.getRight());
		}
	}
}
