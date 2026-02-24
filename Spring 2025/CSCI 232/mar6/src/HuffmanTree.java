import java.util.HashMap;
import java.util.PriorityQueue;

public class HuffmanTree {
	
	private HuffmanNode root;
	private HashMap<Character, Integer> freq;
	private HashMap<Character, String> encodings = new HashMap<>();
	
	public HuffmanTree(HashMap<Character, Integer> freq) {
		this.root = null;
		this.freq = freq;
		createTree();
	}
	
	public void createTree() {
		PriorityQueue<HuffmanNode> queue = new PriorityQueue<HuffmanNode>();
		
		for(char c: freq.keySet()) {
			HuffmanNode node = new HuffmanNode(c, freq.get(c));
			queue.add(node);
		}
		
		HuffmanNode internal = null; //initilized internal object
		while(queue.size() > 1) {
			HuffmanNode first = queue.poll();
			HuffmanNode second = queue.poll();
			
			internal = new HuffmanNode(first, second);
			queue.add(internal);
		}
		
		this.root = internal;
	}
	
	public HuffmanNode getRoot() {
		return this.root;
	}
	
	public void printHuffmanCode(HuffmanNode current, String code) { //prints out huffmanNode: code
		if(current.getLeft() == null && current.getRight() == null) {
			System.out.println(current.getCharacter() + ": " + code);
			encodings.put(current.getCharacter(), code);
			return;
		}
		
		printHuffmanCode(current.getLeft(), code + "0");
		printHuffmanCode(current.getRight(), code + "1");
	}
	
	public String encode(String message) {
		String answer = "";
		for(char c: message.toCharArray()) {
			answer += encodings.get(c);
		}
		return answer;
	}
}
