// Lucas Jones & Henry Stickling
import javax.sound.sampled.*;
import java.io.File;
public class Playlist {
  private Node head;
  private Node tail;
  private Node current;
  private Clip currentClip; 
  private int size;         
   // creates an empty playlist
  public Playlist() {
      this.head = null;
      this.tail = null;
      this.current = null;
      this.currentClip = null; 
      this.size = 0;
  }
  // Adds a song to the playlist
  public void addSong(String title, String composer, String filePath) {
      Node newNode = new Node(title, composer, filePath);
      if (head == null) {
          head = newNode;
          tail = newNode;
          newNode.next = newNode;
          newNode.prev = newNode;
          current = head;
      } else {
          newNode.prev = tail;
          newNode.next = head;
          tail.next = newNode;
          head.prev = newNode;
          tail = newNode;
      }
      size++;
  }
  // Plays the current song
  public void playCurrentSong() {
      if (current == null) {
          System.out.println("No songs in the playlist.");
          return;
      }
      System.out.println("Current Song:");
      System.out.println(current.title + " by " + current.composer);
      System.out.println("----------------------");
      // Stop currently playing song before playing a new one
      stopCurrentClip();
      playSong(current.filePath);
  }
 
  private void playSong(String filePath) {
      try {
          File musicFile = new File(filePath);
          AudioInputStream audioInput = AudioSystem.getAudioInputStream(musicFile);
          Clip clip = AudioSystem.getClip();
          clip.open(audioInput);
          clip.start();  // Start playing song
          currentClip = clip; 
      } catch (Exception e) {
          System.out.println("Error playing the song.");
          e.printStackTrace();
      }
  }
  // Stops playing the current song
  private void stopCurrentClip() {
      if (currentClip != null && currentClip.isRunning()) {
          currentClip.stop();
          currentClip.close(); 
      }
  }
  // Moves to the next song
  public void nextSong() {
      if (current != null) {
          stopCurrentClip();  // Stop the current song before next song
          current = current.next;
          System.out.println("Going to next song");
          System.out.println("Current Song:");
          System.out.println(current.title + " by " + current.composer);
          System.out.println("----------------------");
      } else {
          System.out.println("No songs in the playlist.");
      }
  }
  // Moves to the prev song
  public void previousSong() {
      if (current != null) {
          stopCurrentClip();  // Stop the current song before playing prev song
          current = current.prev;
          System.out.println("Going to previous song");
          System.out.println("Current Song:");
          System.out.println(current.title + " by " + current.composer);
          System.out.println("----------------------");
      } else {
          System.out.println("No songs in the playlist.");
      }
  }
  // Removes song from the playlist
  public void removeCurrentSong() {
      if (current == null) {
          System.out.println("No songs to remove.");
          return;
      }
    
      stopCurrentClip();  // Stops the song before removing it
      if (head == tail) {  
          head = null;
          tail = null;
          current = null;
      } else {
          current.prev.next = current.next;
          current.next.prev = current.prev;
          if (current == head) {
              head = current.next;
          }
          if (current == tail) {
              tail = current.prev;
          }
          current = current.next;
      }
      size--;
      if (current != null) {
           System.out.println("Current Song:");
           System.out.println(current.title + " by " + current.composer);
           System.out.println("----------------------");
      } else {
          System.out.println("Playlist is empty. Ending program...");
          System.out.println("Thanks for listening!");
      }
  }
  // Gets the size
  public int size() {
      return size;
  }
  // Prints playlist
  public void printPlaylist() {
  	int i = 0; // counter
  	if (head == null) {
          System.out.println("The playlist is empty.");
          return;
      }
      Node temp = head;
      do {
      	i ++;   
          System.out.println(i + ". " + temp.title + " by " + temp.composer);
          temp = temp.next;
      } while (temp != head);
      System.out.println("-----------");
      System.out.println("Current Song:");
      System.out.println(current.title + " by " + current.composer);
      System.out.println("----------------------");
  }
}
