// Lucas Jones & Henry Stickling

import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

// Computes MST using Kruskal's algorithm
public class MinimumSpanningTree {
    public static Set<Edge> kruskal(HashMap<String, LinkedList<Edge>> graph) {
        List<Edge> edges = new ArrayList<>();
        for (LinkedList<Edge> list : graph.values()) {
            edges.addAll(list);
        }

        edges.sort(Comparator.comparingInt(Edge::getWeight));
        HashMap<String, String> parent = new HashMap<>();
        for (String vertex : graph.keySet()) {
            parent.put(vertex, vertex);
        }

        // Gets all unique edges
        Set<Edge> mst = new HashSet<>();
        for (Edge edge : edges) {
            String root1 = find(parent, edge.getActor1());
            String root2 = find(parent, edge.getActor2());

            if (!root1.equals(root2)) {
                mst.add(edge);
                parent.put(root1, root2);
            }
        }

        return mst;
    }

    private static String find(HashMap<String, String> parent, String actor) {
        while (!parent.get(actor).equals(actor)) {
            actor = parent.get(actor);
        }
        return actor;
    }
}
