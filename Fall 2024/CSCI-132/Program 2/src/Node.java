// Lucas Jones & Henry Stickling
public class Node {
   String title;
   String composer;
   String filePath;
   Node next;
   Node prev;
   public Node(String title, String composer, String filePath) {
       this.title = title;
       this.composer = composer;
       this.filePath = filePath;
       this.next = null;
       this.prev = null;
   }
}

