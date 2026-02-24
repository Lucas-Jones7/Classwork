
public class Node {
	
	private String code;
	private String city;
	private String next;
	private String prev;
	
	public Node(String c, String city) {
		this.code= c;
		this.city = city;
		this.next = null;
		this.prev = null;
	}
	
	public Node getNext() {
		return this.next;
	}
	
	public Node getPrev() {
		return this.prev;
	}
	
	public void setNext(node newNode) {
		
	}
}
