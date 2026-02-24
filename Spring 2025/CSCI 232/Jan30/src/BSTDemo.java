
public class BSTDemo {
	
	public static void main(String[] args) {
		
		BST tree = new BST();
		
				
		tree.insert(44);
		tree.insert(17);
		tree.insert(88);
		tree.insert(77);
		tree.insert(81);
		tree.insert(5);
		tree.insert(21);
		tree.insert(99);
		tree.insert(120);
		tree.insert(19);
		
		tree.depthFirst(tree.getRoot());
	}

}
