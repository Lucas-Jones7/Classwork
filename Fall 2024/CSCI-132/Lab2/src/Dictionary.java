import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Arrays;

public class Dictionary {
    private String[] words;

    // Constructor that initializes the dictionary by reading the file
    public Dictionary() {
        this.words = readFromFile();
        Arrays.sort(this.words); // Sort the words in alphabetical order
    }

    // Method to read words from the file
    private String[] readFromFile() {
        String[] wordsArray = new String[41193];
        try (BufferedReader br = new BufferedReader(new FileReader("words.txt"))) {
            String line;
            int index = 0;
            while ((line = br.readLine()) != null) {
                wordsArray[index++] = line.trim();
            }
        } catch (IOException e) {
            System.err.println("Error reading the file.");
            e.printStackTrace();
        }
        return wordsArray;
    }

    // Method to return the first word in the dictionary
    public String firstWord() {
        return words[0];
    }

    // Method to return the last word in the dictionary
    public String lastWord() {
        return words[words.length - 1];
    }

    // Method to return the longest word in the dictionary
    public String longestWord() {
        String longest = "";
        for (String word : words) {
            if (word.length() > longest.length()) {
                longest = word;
            }
        }
        return longest;
    }

    // Method to count the number of words that start with a specific letter
    public int countByLetter(char inputLetter) {
        int count = 0;
        for (String word : words) {
            if (word.charAt(0) == inputLetter) {
                count++;
            }
        }
        return count;
    }
}
