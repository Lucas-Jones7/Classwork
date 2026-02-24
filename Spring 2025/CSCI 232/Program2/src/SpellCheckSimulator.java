//Lucas Jones & Henry Stickling

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;
public class SpellCheckSimulator {
	Scanner scanner = new Scanner(System.in);
	LoadFiles fileloader = new LoadFiles();
	private HashSet<String> dictionary = fileloader.loadDictionary();
	private HashMap<String, Integer> word_frequency = new HashMap<>();
	
	public void printMenu() {
		
		System.out.println("Document Spell Check Program");
		System.out.println("----------------------------");
		System.out.println("1: Spell Check your document (input.txt)");
		System.out.println("2: Print word frequency alphabetically");
		System.out.println("3: Print word frequency from greatest to least");
		System.out.println("4: Exit program");	
				
	}
	
	public void simulate() {
		boolean looper = true;
		while(looper) {
			printMenu();
			
			System.out.println("Your choice? ");
			int choice = scanner.nextInt();
			
			switch(choice) {
				
				default:
					System.out.println("Please enter valid input. ");
					break;
				case 1:
				try {
					spellChecker();
				} catch (FileNotFoundException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
					break;
				case 2:
					wordFrequencyAlph();
					break;
				case 3:
					wordFrequencyNum();
					break;
				case 4:
					scanner.close();
					looper = false;
					return;
			}
		}
	}
	private void wordFrequencyNum() {
	    word_frequency.clear();
	    try {
	        LinkedList<String> input = fileloader.loadInput();
	        for (String word : input) {
	            word_frequency.put(word.toLowerCase(), word_frequency.getOrDefault(word.toLowerCase(), 0) + 1);
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    List<Map.Entry<String, Integer>> sortedWords = new ArrayList<>(word_frequency.entrySet());
	    sortedWords.sort((a, b) -> b.getValue() - a.getValue());
	    int prevCount = -1;
	    for (Map.Entry<String, Integer> entry : sortedWords) {
	        int count = entry.getValue();
	       
	        if (count != prevCount) {
	            if (prevCount != -1) System.out.println();
	            System.out.print(count + ": ");
	            prevCount = count;
	        } else {
	            System.out.print(", ");
	        }
	        System.out.print(entry.getKey());
	    }
	    System.out.println();
	}
	
	private void wordFrequencyAlph() {
		word_frequency.clear();
	    try {
	        LinkedList<String> input = fileloader.loadInput();
	        for (String word : input) {
	            word_frequency.put(word.toLowerCase(), word_frequency.getOrDefault(word.toLowerCase(), 0) + 1);
	        }
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
	    List<String> wordList = new ArrayList<>(word_frequency.keySet());
	    Collections.sort(wordList);
	    for (String word : wordList) {
	        System.out.println(word + ": " + word_frequency.get(word));
	    }
	}
	private void spellChecker() throws FileNotFoundException, IOException {
		
		StringBuilder output = new StringBuilder();
	   
		try (BufferedReader br = new BufferedReader(new FileReader("input.txt"))) {
	        String line;
	        while ((line = br.readLine()) != null) {
	            String[] words = line.split(" ");
	            for (int i = 0; i < words.length; i++) {
	                String cleanedWord = words[i].replaceAll("[!.,?]", "");
	               
	                if (!cleanedWord.isEmpty() && !dictionary.contains(cleanedWord.toLowerCase())) {
	                    output.append("<").append(words[i]).append(">");
	                } else {
	                    output.append(words[i]);
	                }
	                if (i < words.length - 1) {
	                    output.append(" ");
	                }
	            }
	            output.append("\n");
	        }
	    }
	    System.out.println(output.toString());
	}
	
}
