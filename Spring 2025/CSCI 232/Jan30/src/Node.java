
public class Node {

	
	private int value;
	private Node left;
	private Node right;
	private Node parent;
	
	public Node(int newValue) {
		this.value = newValue;
	}
	
	public int getValue() {
		return this.value;
	}
	
	public void setValue(int newValue) {
		this.value = newValue;
	}
	
	public Node getLeft() {
		return this.left;
	}
	
	public Node getRight() {
		return this.right;
	}
	
	public void setLeft(Node newNode) {
		this.left = newNode;
	}
	
	public void setRight(Node newNode) {
		this.right = newNode;
	}
	
	public Node getParent() {
		return this.parent;
	}
	
	public void setParent(Node newNode) {
		this.parent = newNode;
	}
}
