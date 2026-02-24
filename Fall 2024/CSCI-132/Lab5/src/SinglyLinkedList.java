public class SinglyLinkedList {
    private Node head;
    private Node tail;
    private int size;

    public SinglyLinkedList() {
        head = null;
        tail = null;
        size = 0;
    }

    public void addToFront(Node newMovie) {
        if (head == null) {
            head = newMovie;
            tail = newMovie;
        } else {
            newMovie.next = head;
            head = newMovie;
        }
        size++;
    }

    public void addToBack(Node newMovie) {
        if (head == null) {
            head = newMovie;
            tail = newMovie;
        } else {
            tail.next = newMovie;
            tail = newMovie;
        }
        size++;
    }

    public void removeFirst() {
        if (head == null) {
            System.out.println("List is empty, nothing to remove");
            return;
        }
        head = head.next;
        if (head == null) {
            tail = null;
        }
        size--;
    }

    public void insert(Node newMovie, int N) {
        if (N <= 0 || N >= size) {
            System.out.println("Invalid insertion index.");
            return;
        }

        Node current = head;
        for (int i = 1; i < N - 1; i++) {
            current = current.next;
        }

        newMovie.next = current.next;
        current.next = newMovie;
        size++;
    }

    public void searchForMovie(String m) {
        Node current = head;
        int position = 1;
        while (current != null) {
            if (current.title.equals(m)) {
                System.out.println("Movie: " + current.title + " (" + current.releaseDate + ") was found at spot #" + position);
                return;
            }
            current = current.next;
            position++;
        }
        System.out.println("Movie: " + m + " was not found");
    }

    public int getSize() {
        return size;
    }

    public void printList() {
        Node current = head;
        int position = 1;
        while (current != null) {
            System.out.println(position + ". " + current.title + " (" + current.releaseDate + ")");
            current = current.next;
            position++;
        }
    }
}
