// Lucas Jones & Henry Stickling
import java.io.IOException;
import java.util.Scanner;

public class WordleDemo {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.println("Would you like to play on easy, normal, or hard?");
        String mode = scanner.nextLine().toLowerCase();

        try {
            Wordle game = new Wordle(mode);
            game.playGame();
        } catch (IOException e) {
            System.out.println("Error loading word list: " + e.getMessage());
        }
    }
}
