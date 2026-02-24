public class Node {
    String location;
    String continent;
    int elevation;
    Node next;
    Node prev;

    public Node(String location, String continent, int elevation) {
        this.location = location;
        this.continent = continent;
        this.elevation = elevation;
        this.next = null;
        this.prev = null;
    }

    @Override
    public String toString() {
        return location + " (" + continent + ") Elevation: " + elevation;
    }
}
