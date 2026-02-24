import java.util.HashMap;
import java.util.Scanner;

public class Translator {

	public static void main(String[] args) {
		HashMap<String, String> translator = new HashMap<String, String>();
		
		translator.put("hello", "ahoy"); // maps hello to ahoy
		translator.put("friend", "matey");
		translator.put("yes", "aye");
		translator.put("stop", "heave");
		translator.put("CSCI232", "Hell");
		
		Scanner input = new Scanner(System.in); // gets a english sentence with scanner and splits all words into an array
		String sentence = input.nextLine();
		String[] splitted = sentence.split(" ");
		
		// iterate through all words in sentence
		String pirate_sentence = "";
		for(String word: splitted) { 
			if(translator.containsKey(word)) {
				pirate_sentence += translator.get(word);
			}
			else {
				pirate_sentence += word + " ";
			}
		}
		System.out.println(pirate_sentence);
	}

}
