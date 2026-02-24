import java.util.HashMap;

public class HuffmanTreeDemo {
	
	public static void main(String[] args) {
		
		String message = "hello world!";
		HashMap<Character, Integer> freq = new HashMap<Character, Integer>();
		getCharFrequencies(message, freq);
		
		HuffmanTree huff = new HuffmanTree(freq); //creates huffman tree
		huff.printHuffmanCode(huff.getRoot(), "");
		System.out.println(huff.encode(message));
	}
	
	public static void getCharFrequencies(String message, HashMap<Character, Integer> freq) {
		for(char c: message.toCharArray()) {
			if(freq.containsKey(c)) {
				freq.put(c, freq.get(c) + 1);
			}
			else {
				freq.put(c, 1);
			}
		}
	}
}
