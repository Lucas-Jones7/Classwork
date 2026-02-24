
public class HuffmanNode implements Comparable<HuffmanNode> {
	
	private char character;
	private int frequency;
	private HuffmanNode left;
	private HuffmanNode right;
		
	//Constructor for leaf node
	public HuffmanNode(char c, int f) {
		this.character = c;
		this.frequency = f;
		this.left = null;
		this.right = null;
	}
	
	//Internal Node constructor
	public HuffmanNode(HuffmanNode first, HuffmanNode second) { // merges two huffman nodes into a tree
		this.frequency = first.getFrequency() + second.getFrequency();
		this.left = first;
		this.right = second;
		this.character = '*';
	}
	
	public char getCharacter() {
		return this.character;
	}
	
	public int getFrequency() {
		return this.frequency;
	}

	@Override
	public int compareTo(HuffmanNode other) {
		// TODO Auto-generated method stub
		if(this.frequency > other.frequency) {
			return 1;
		}
		else if(this.frequency == other.frequency) {
			return 0;
		}
		else {
			return 1;
		}
			
	}
	public HuffmanNode getLeft() {
		return this.left;
	}
	
	public HuffmanNode getRight() {
		return this.right;
	}
}
