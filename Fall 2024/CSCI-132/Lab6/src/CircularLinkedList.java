import java.io.BufferedReader;
import java.io.FileReader;

public class CircularLinkedList implements Lab6Methods {
    private Node head;
    private Node tail;
    private String fileName;

    public CircularLinkedList(String fileName) {
        this.fileName = fileName;
        fillLinkedList();
    }

    public void fillLinkedList() {
        try (BufferedReader br = new BufferedReader(new FileReader(fileName))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                String location = parts[0].trim();
                String continent = parts[1].trim();
                int elevation = Integer.parseInt(parts[2].trim());
                Node newNode = new Node(location, continent, elevation);
                append(newNode);
            }
        } catch (Exception e) {
            System.out.println("Error reading file: " + e.getMessage());
        }
    }

    public void append(Node newNode) {
        if (head == null) {
            head = newNode;
            tail = newNode;
            head.next = head;
            head.prev = head;
        } else {
            tail.next = newNode;
            newNode.prev = tail;
            newNode.next = head;
            head.prev = newNode;
            tail = newNode;
        }
    }

    public void printLinkedList() {
        if (head == null) return;

        Node current = head;
        do {
            System.out.println("•" + current);
            current = current.next;
        } while (current != head);
    }

    public void search(String searchValue) {
        if (head == null) {
            System.out.println(searchValue + " is not part of the great circle");
            return;
        }

        Node current = head;
        int position = 1;
        do {
            if (current.location.equalsIgnoreCase(searchValue)) {
                System.out.println(current.location + " is located at spot #" + position);
                return;
            }
            current = current.next;
            position++;
        } while (current != head);

        System.out.println(searchValue + " is not part of the great circle");
    }

    public void findGreatestElevationDifference() {
        if (head == null || head.next == head) return;

        Node current = head;
        Node maxNode1 = head;
        Node maxNode2 = head.next;
        int maxDifference = Math.abs(head.elevation - head.next.elevation);

        do {
            int difference = Math.abs(current.elevation - current.next.elevation);
            if (difference > maxDifference) {
                maxDifference = difference;
                maxNode1 = current;
                maxNode2 = current.next;
            }
            current = current.next;
        } while (current != head);

        System.out.println("The greatest elevation difference is between " + maxNode1.location + " and " + maxNode2.location + " with a difference of " + maxDifference + " feet.");
    }
}
