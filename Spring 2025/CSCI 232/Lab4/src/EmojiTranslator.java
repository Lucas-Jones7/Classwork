import java.io.File;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.Scanner;

public class EmojiTranslator {
	HashMap<String, String> emojimap = loadHashTable();
	
	public HashMap<String, String> loadHashTable(){
		
		HashMap<String, String> emojimap = new HashMap<String, String>();
		File file = new File("emojis.txt");
		Scanner txt = null;
		
		try { 
			txt = new Scanner (file);
			while(txt.hasNextLine()) {
				String emoji_list = txt.nextLine();
				String[] parts = emoji_list.split(",");
				String emoji = parts[0];
				String phrase = parts[1].trim();
				emojimap.put(phrase, emoji);
			}
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
			
		} 
		txt.close();
		return emojimap;
	}
	
	public String convert(String string) {
		String emoji_sentence = "";
		String[] split = string.split(" ");
		for(String word: split) {
			if(emojimap.containsKey(word)) {
				emoji_sentence += emojimap.get(word) + " ";
			}
			else {
				emoji_sentence += word + " ";
			}
		}
		return emoji_sentence.toString().trim();
	}
	
	public char[] getEmoji(String string) {
		char[] emojiArray = new char[1];
		if(emojimap.containsKey(":" + string + ":")) {
			emojiArray = emojimap.get(":" + string + ":").toCharArray();
			return emojiArray;
		}
		else {
			System.out.println("Emoji not found: " + string);
			return emojiArray;
		}
		
	}
}

 