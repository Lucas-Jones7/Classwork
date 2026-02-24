// Lucas Jones & Henry Stickling

public class Node {
	private int value;
	private String name;
	private Node yesNode;
	private Node noNode;
	private Node parent;
	
	public Node (int newValue, String newName) {
		this.value = newValue;
		this.name = newName;
		
	}
	public int getValue() {
		return this.value;
	}
	public String getName() {
		return this.name;
	}
	public void setValue(int newValue) {
		this.value = newValue;
	}
	public void setName(String newName) {
		this.name = newName;
	}
	public Node getYes() {
		return this.yesNode;
	}
	public Node getNo() {
		return this.noNode;
	}
	public void setYesChild(Node newNode) {
		this.yesNode = newNode;
	}
	public void setNoChild(Node newNode) {
		this.noNode = newNode;
	}
	public Node getParent() {
		return this.parent;
	}
	public void setParent(Node newNode) {
		this.parent = newNode;
	}
	public boolean isAnimal() {
		if (this.getYes() == null || this.getNo() == null) {
			return true;
		}else {
			return false;
			}
	}
	public boolean isPrompter() {
		if (this.getYes() != null && this.getName() != null) {
			return true;
		}else {
			return false;
		}
	}
	
	
}
