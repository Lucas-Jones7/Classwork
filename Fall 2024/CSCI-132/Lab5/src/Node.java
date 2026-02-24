public class Node {
    String title;
    int releaseDate;
    Node next;

    public Node(String title, int releaseDate) {
        this.title = title;
        this.releaseDate = releaseDate;
        this.next = null;
    }
}
