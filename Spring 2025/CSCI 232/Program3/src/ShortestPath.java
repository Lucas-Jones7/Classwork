// Lucas Jones & Henry Stickling

import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.PriorityQueue;
import java.util.Queue;
import java.util.Set;

// finds shortest path between actors using Dijkstra's algorithm
public class ShortestPath {
    public static List<String> dijkstra(HashMap<String, LinkedList<Edge>> graph, String start, String end) {
        if (!graph.containsKey(start) || !graph.containsKey(end)) return null;

        HashMap<String, Integer> distance = new HashMap<>();
        HashMap<String, String> previous = new HashMap<>();
        PriorityQueue<PriorityVertex> pq = new PriorityQueue<>();

        for (String actor : graph.keySet()) {
            distance.put(actor, Integer.MAX_VALUE);
        }
        distance.put(start, 0);
        pq.add(new PriorityVertex(start, 0));

        while (!pq.isEmpty()) {
            PriorityVertex current = pq.poll();
            if (current.name.equals(end)) break;

            for (Edge edge : graph.get(current.name)) {
                String neighbor = edge.getActor2();
                int newDist = distance.get(current.name) + 1;
                if (newDist < distance.get(neighbor)) {
                    distance.put(neighbor, newDist);
                    previous.put(neighbor, current.name);
                    pq.add(new PriorityVertex(neighbor, newDist));
                }
            }
        }

        if (!previous.containsKey(end)) return null;

        List<String> path = new LinkedList<>();
        for (String at = end; at != null; at = previous.get(at)) {
            path.add(0, at);
        }
        return path;
    }
    
    public static List<Edge> dijkstraWithMovies(HashMap<String, LinkedList<Edge>> graph, String start, String end) {
        if (!graph.containsKey(start) || !graph.containsKey(end)) return null;

        HashMap<String, Integer> distance = new HashMap<>();
        HashMap<String, Edge> previousEdge = new HashMap<>();
        Set<String> visited = new HashSet<>();
        Queue<String> queue = new LinkedList<>();

        // Initializes distances
        for (String actor : graph.keySet()) {
            distance.put(actor, Integer.MAX_VALUE);
        }

        distance.put(start, 0);
        queue.add(start);

        while (!queue.isEmpty()) {
            String current = queue.poll();
            visited.add(current);

            for (Edge edge : graph.get(current)) {
                String neighbor = edge.getOther(current);
                if (visited.contains(neighbor)) continue;

                int newDist = distance.get(current) + 1;
                if (newDist < distance.get(neighbor)) {
                    distance.put(neighbor, newDist);
                    previousEdge.put(neighbor, edge);
                    queue.add(neighbor);
                }
            }
        }

        if (!previousEdge.containsKey(end)) {
            return null; // No path exists
        }

        LinkedList<Edge> path = new LinkedList<>();
        String current = end;
        while (!current.equals(start)) {
            Edge edge = previousEdge.get(current);
            path.addFirst(edge);
            current = edge.getOther(current);
        }

        return path;
    }
}

