// Lucas Jones & Henry Stickling

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
        graph.buildGraphFromFile("actors.txt"); // Builds actor graph

        Set<Edge> mstEdges = null;
        
        // Loop for menu options
        while (true) {
            System.out.println("Enter your choice: ");
            System.out.println("1. Print out MST Information");
            System.out.println("2. Find Shortest Path from one Actor to another");
            System.out.println("3. Find Longest path in MST");
            System.out.println("4. Exit");

            int choice = scanner.nextInt();
            scanner.nextLine(); 

            if (choice == 1) {
                mstEdges = MinimumSpanningTree.kruskal(graph.getGraph()); // Builds MST using Kruskal's Algorithm

                System.out.println("Edges in MST:");
                System.out.println("---------------------");

                int count = 1;
                for (Edge e : mstEdges) {
                    System.out.println(count++ + ". " + e.getActor1() + " - " + e.getActor2() + " (" + e.getMovie() + ")");
                }

                // Prints list of unique movies from MST
                HashSet<String> uniqueMovies = new HashSet<>();
                for (Edge e : mstEdges) {
                    uniqueMovies.add(e.getMovie());
                }

                System.out.println("\nList of movies to watch that covers all 30 Actors:");
                System.out.println("---------------------");

                int movieNum = 1;
                for (String movie : uniqueMovies) {
                    System.out.println(movieNum++ + ". " + movie);
                }
            }
            
            // finds and prints shortest possible path between actors
            else if (choice == 2) {
                System.out.print("Enter starting actor:\n");
                String start = scanner.nextLine();
                System.out.print("Enter destination actor:\n");
                String end = scanner.nextLine();

                List<Edge> path = ShortestPath.dijkstraWithMovies(graph.getGraph(), start, end); // You must modify your dijkstra to return List<Edge>

                if (path == null) {
                    System.out.println("Path does not exist to " + end);
                } else {
                    for (Edge edge : path) {
                        System.out.println(edge.getActor1() + " acted with " + edge.getActor2() + " in " + edge.getMovie());
                    }
                    System.out.println("Number of hops: " + path.size());
                }
            }

            // finds and prints longest path in MST
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

            // closes program
            else if (choice == 4) {
                break;
            }
        }

        scanner.close();
    }

    // finds farthest actor in MST using BFS
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
