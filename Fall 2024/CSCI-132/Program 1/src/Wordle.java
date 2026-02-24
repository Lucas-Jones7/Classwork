// Lucas Jones & Henry Stickling
import java.util.*;
import java.io.*;

public class Wordle {
    private String wordToGuess;
    private int maxGuesses;
    private List<String> wordList;

    public Wordle(String mode) throws IOException {
        wordList = loadWords("wordle_words.txt");
        wordToGuess = getRandomWord();
        setMode(mode);
    }

    // Reads file and adds to list
    private List<String> loadWords(String filename) throws IOException {
        List<String> words = new ArrayList<>();
        Scanner scanner = new Scanner(new File(filename));
        while (scanner.hasNextLine()) {
            words.add(scanner.nextLine().toUpperCase());
        }
        scanner.close();
        return words;
    }

    // Selects a random word from the list
    private String getRandomWord() {
        Random random = new Random();
        return wordList.get(random.nextInt(wordList.size()));
    }

    // Sets the number of guesses allowed based on the chosen difficulty
    private void setMode(String mode) {
        mode = mode.toLowerCase();
        
        if (mode.equals("easy")) {
            maxGuesses = 8;
        } else if (mode.equals("normal")) {
            maxGuesses = 6;
        } else if (mode.equals("hard")) {
            maxGuesses = 4;
        } else {
            maxGuesses = 6; 
        }
    }


    // Game loop
    public void playGame() {
        Scanner scanner = new Scanner(System.in);
        int guessesMade = 0;

        System.out.println("You have " + maxGuesses + " guesses.");
        
        while (guessesMade < maxGuesses) {
            System.out.println("Enter your guess: ");
            String guess = scanner.nextLine().toUpperCase();

            // checks to see if the input is 5 chars
            if (guess.length() != 5) {
                System.out.println("Invalid input... try again");
                continue;
            }

            guessesMade++;
            String feedback = getFeedback(guess);
            System.out.println(feedback);

            // Check if the guess is correct
            if (guess.equals(wordToGuess)) {
                System.out.println("You got it!");
                System.out.println("That took " + guessesMade + " guesses.");
                return;
            } else {
                System.out.println("Incorrect!");
                if (guessesMade < maxGuesses) {
                    System.out.println("You have " + (maxGuesses - guessesMade) + " guesses left.");
                }
            }
        }
        System.out.println("You have 0 guesses left.");
        System.out.println("Game over"); 
        System.out.println("The word was " + wordToGuess);
    }

    // 
    private String getFeedback(String guess) {
        String feedback = ""; 

        for (int i = 0; i < 5; i++) {
            char guessChar = guess.charAt(i);
            if (guessChar == wordToGuess.charAt(i)) {
                feedback += "✔️"; // Correct letter and index
            } else if (wordToGuess.indexOf(guessChar) >= 0) {
                feedback += "🟨 "; // Letter is in word but in wrong index
            } else {
                feedback += "❌"; // If letter is not in word
            }
        }

        return feedback; 
    }

}
