
public class RedBlackTreeVerifier {
	
	public static void main(String[] args ) {
	 
		RedBlackBST rbt = new RedBlackBST();
		
		rbt.insert(10, "black");
		rbt.insert(2, "black");
		rbt.insert(18, "red");
		rbt.insert(12, "black");
		rbt.insert(50, "black");
		rbt.insert(17, "red");
		
		rbt.verifyRedBlackTree();
		
	}
}
