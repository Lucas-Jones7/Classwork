// Lucas Jones & Henry Stickling

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

public class UndirectedWeightedGraph {
    private HashMap<String, LinkedList<Edge>> adjacencyList = new HashMap<>();

    // Builds graph from file 
    public void buildGraphFromFile(String filename) throws IOException {
        BufferedReader br = new BufferedReader(new FileReader(filename));
        HashMap<String, LinkedList<String>> movieToActors = new HashMap<>();

        String line;
        while ((line = br.readLine()) != null) {
            String[] parts = line.split("\\|");
            if (parts.length == 2) {
                String actor = parts[0].trim();
                String movie = parts[1].trim();
                movieToActors.computeIfAbsent(movie, k -> new LinkedList<>()).add(actor);
            }
        }

        for (String movie : movieToActors.keySet()) {
            List<String> actors = movieToActors.get(movie);
            for (int i = 0; i < actors.size(); i++) {
                for (int j = i + 1; j < actors.size(); j++) {
                    addEdge(actors.get(i), actors.get(j), movie);
                }
            }
        }
    }

    private void addEdge(String a1, String a2, String movie) {
        Edge edge1 = new Edge(a1, a2, movie);
        Edge edge2 = new Edge(a2, a1, movie);

        adjacencyList.computeIfAbsent(a1, k -> new LinkedList<>()).add(edge1);
        adjacencyList.computeIfAbsent(a2, k -> new LinkedList<>()).add(edge2);
    }

    public HashMap<String, LinkedList<Edge>> getGraph() {
        return adjacencyList;
    }

    public Set<String> getVertices() {
        return adjacencyList.keySet();
    }

    public List<Edge> getAllEdges() {
        Set<String> seen = new HashSet<>();
        List<Edge> allEdges = new ArrayList<>();
        for (String actor : adjacencyList.keySet()) {
            for (Edge e : adjacencyList.get(actor)) {
                String key = e.getActor1() + "-" + e.getActor2() + "-" + e.getMovie();
                String reverseKey = e.getActor2() + "-" + e.getActor1() + "-" + e.getMovie();
                if (!seen.contains(reverseKey)) {
                    allEdges.add(e);
                    seen.add(key);
                }
            }
        }
        return allEdges;
    }
}
