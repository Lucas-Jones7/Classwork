//Lucas Jones & Henry Stickling


import java.io.*;
import java.util.HashSet;
import java.util.LinkedList;
public class LoadFiles {
	
	public HashSet<String> dictionary = new HashSet<>();
	
   public HashSet<String> loadDictionary() {
       try (BufferedReader br = new BufferedReader(new FileReader("words.txt"))) {
           String word;
           while ((word = br.readLine()) != null) {
               dictionary.add(word.toLowerCase());
           }
       } catch (IOException e) {
           System.out.println("Error reading");
       }
		return dictionary;
   }
  
   public LinkedList<String> loadInput() throws FileNotFoundException, IOException {
   	
		LinkedList<String> output = new LinkedList<>();
		try (BufferedReader br = new BufferedReader(new FileReader("input.txt"))) {
			String line;
		
			while ((line = br.readLine()) != null) {		 
				String[] splitted = line.split(" ");
		    		for (String word : splitted) {
		    			String cleaned = removePunc(word);
		    			if (!cleaned.isEmpty()) {
		    				output.add(cleaned);
		  			}
		   		}
		    }
		}
		
		return output;
	
   }
  
   private String removePunc(String word) {
   	return word.replaceAll("[!.,?]", "");
   }
}
