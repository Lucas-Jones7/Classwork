import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Queue;
import java.util.Scanner;
import java.util.Set;

public class Program3Demo {
    public static void main(String[] args) throws Exception {
        Scanner scanner = new Scanner(System.in);
        UndirectedWeightedGraph graph = new UndirectedWeightedGraph();
        graph.buildGraphFromFile("actors.txt");

        Set<Edge> mstEdges = null;

        while (true) {
            System.out.println("Menu:\n1. Minimum Spanning Tree\n2. Shortest Path\n3. Longest Path in MST\n4. Exit");
            int choice = scanner.nextInt();
            scanner.nextLine(); // clear buffer

            if (choice == 1) {
                mstEdges = MinimumSpanningTree.kruskal(graph.getGraph());
                for (Edge e : mstEdges) {
                    System.out.println(e);
                }

                HashSet<String> uniqueMovies = new HashSet<>();
                for (Edge e : mstEdges) {
                    uniqueMovies.add(e.getMovie());
                }

                System.out.println("Unique movies in MST:");
                for (String m : uniqueMovies) System.out.println(m);
            }

            else if (choice == 2) {
                System.out.print("Enter start actor: ");
                String start = scanner.nextLine();
                System.out.print("Enter end actor: ");
                String end = scanner.nextLine();

                List<String> path = ShortestPath.dijkstra(graph.getGraph(), start, end);
                if (path == null) {
                    System.out.println("No path exists.");
                } else {
                    System.out.println("Shortest path: " + path);
                    System.out.println("Number of hops: " + (path.size() - 1));
                }
            }

            else if (choice == 3) {
                if (mstEdges == null) {
                    System.out.println("Run MST first.");
                    continue;
                }
                HashMap<String, List<String>> mstAdjList = new HashMap<>();
                for (Edge e : mstEdges) {
                    mstAdjList.computeIfAbsent(e.getActor1(), k -> new ArrayList<>()).add(e.getActor2());
                    mstAdjList.computeIfAbsent(e.getActor2(), k -> new ArrayList<>()).add(e.getActor1());
                }

                String farthestNode = bfsFindFarthest(mstAdjList, mstAdjList.keySet().iterator().next()).getKey();
                Map.Entry<String, List<String>> result = bfsFindFarthest(mstAdjList, farthestNode);
                System.out.println("Longest path: " + result.getValue());
                System.out.println("Hops: " + (result.getValue().size() - 1));
            }

            else if (choice == 4) {
                break;
            }
        }
        scanner.close();
    }

    static Map.Entry<String, List<String>> bfsFindFarthest(HashMap<String, List<String>> adj, String start) {
        Queue<String> q = new LinkedList<>();
        HashMap<String, String> parent = new HashMap<>();
        q.add(start);
        parent.put(start, null);

        String farthest = start;

        while (!q.isEmpty()) {
            String curr = q.poll();
            farthest = curr;

            for (String neighbor : adj.getOrDefault(curr, new ArrayList<>())) {
                if (!parent.containsKey(neighbor)) {
                    parent.put(neighbor, curr);
                    q.add(neighbor);
                }
            }
        }

        List<String> path = new LinkedList<>();
        for (String at = farthest; at != null; at = parent.get(at)) {
            path.add(0, at);
        }

        return new AbstractMap.SimpleEntry<>(farthest, path);
    }
}
