// Lucas Jones & Henry Stickling
import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.ArrayList;
import java.util.Random;
public class Program2Demo {
   public static void main(String[] args) {
       // gets song info
       ArrayList<String[]> songs = loadSongsFromFile("songs.txt");
       // gets the size of the playlist
       Scanner scanner = new Scanner(System.in);
       System.out.println("Enter playlist size: ");
       int n = scanner.nextInt();
       while (n < 3 || n > 20) {
           System.out.println("Please enter a valid number between 3 and 20.");
           n = scanner.nextInt();
       }
       // Creates a playlist with random songs
       Playlist playlist = new Playlist();
       Random random = new Random();
       ArrayList<Integer> chosenIndices = new ArrayList<>();
       while (playlist.size() < n) {  // Use the size method here
           int randIndex = random.nextInt(songs.size());
           if (!chosenIndices.contains(randIndex)) {
               String[] songData = songs.get(randIndex);
               playlist.addSong(songData[0], songData[1], songData[2]);
               chosenIndices.add(randIndex);
           }
       }
  
       playlist.printPlaylist();
       // Initiates the playlist menu
       boolean running = true;
       while (running) {
           System.out.println("1. Play current song");
           System.out.println("2. Next song");
           System.out.println("3. Previous song");
           System.out.println("4. Remove current song");
           System.out.println("5. Quit playlist");
           int choice = scanner.nextInt();
           switch (choice) {
               case 1:
                   playlist.playCurrentSong();
                   break;
               case 2:
                   playlist.nextSong();
                   break;
               case 3:
                   playlist.previousSong();
                   break;
               case 4:
                   playlist.removeCurrentSong();
                   break;
               case 5:
                   System.out.println("Thanks for listening!");
               	running = false;
                   break;
               default:
                   System.out.println("Invalid choice.");
           }
       }
       scanner.close();
   }
   // loads songs from txt file
   private static ArrayList<String[]> loadSongsFromFile(String fileName) {
       ArrayList<String[]> songs = new ArrayList<>();
       try {
           File file = new File(fileName);
           Scanner sc = new Scanner(file);
           while (sc.hasNextLine()) {
               String line = sc.nextLine();
               String[] data = line.split(",");
               songs.add(data);
           }
           sc.close();
       } catch (FileNotFoundException e) {
           System.out.println("Error: File not found.");
       }
       return songs;
   }
}
