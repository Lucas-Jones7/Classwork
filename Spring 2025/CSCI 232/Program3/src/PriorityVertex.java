// Lucas Jones & Henry Stickling

// Used Dijkstra's algorithm
public class PriorityVertex implements Comparable<PriorityVertex> {
    String name;
    int distance;

    public PriorityVertex(String name, int distance) {
        this.name = name;
        this.distance = distance;
    }
    
    // sorts by distance 
    public int compareTo(PriorityVertex other) {
        return Integer.compare(this.distance, other.distance);
    }
}
