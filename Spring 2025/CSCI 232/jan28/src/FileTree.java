import java.util.LinkedList;

public class FileTree {

	private Node root;
	private Node current;
	
	public FileTree() {
		this.root = new Node("~");
		this.current = root;
	}
	
	public boolean insert(String directory){
		//check for invalid directory name
		if( directory == null || directory.equals(" ") || directory.equals("~")) {
			return false;
		}
		else {
			Node newNode = new Node(directory);
			newNode.setParent(current);
			current.addChild(newNode);
			return true;
		}	
	}
	
	public boolean moveDown(String directory) {
		
		LinkedList<Node> children = current.getChildren();
		
		for(Node child: children) {
			//look for a match, and move down
			if(child.getName().equals(directory)) {
				current = child;
				return true;	
			}
		}
		return false;
	}
	
	public void moveUp(){
		if(current != root) {
			current = current.getParent();
		}
	}
	
	public void goHome() {
		current = root;
	}
	
	public String getCurrentLocation() {
		return current.getName();
	}
	
	public String getChildren() {
		// School   Work   Games    Pictures
		String files = "";
		LinkedList<Node> children = current.getChildren();
		for(Node c: children) {
			files += c.getName() + " ";
		}
		return files;
	}
	
	public boolean remove(String argument) {
		//TO DO: Lab 2
		return false;
	}
	
	public String getPath() {
		//TO DO: Lab 2
		return null;
	}
	
}
