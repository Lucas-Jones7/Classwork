import java.util.HashMap;
import java.util.LinkedList;

// Represents the graph as an adjacency list
class Graph {
    private HashMap<String, LinkedList<Edge>> adjList;

    public Graph() {
        adjList = new HashMap<>();
    }

// Adds an edge for both actors (undirected)
public void addEdge(String actor1, String actor2, String movie) {
        Edge edge1 = new Edge(actor1, actor2, movie);
        Edge edge2 = new Edge(actor2, actor1, movie);

        adjList.putIfAbsent(actor1, new LinkedList<>());
        adjList.putIfAbsent(actor2, new LinkedList<>());

        adjList.get(actor1).add(edge1);
        adjList.get(actor2).add(edge2);
    }

// method for printing out the adjacency list
    public void printGraph() {
        for (String actor : adjList.keySet()) {
            System.out.println(actor + ": " + adjList.get(actor));
        }
    }
}
