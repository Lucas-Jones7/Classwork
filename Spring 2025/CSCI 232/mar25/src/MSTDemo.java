import java.util.HashSet;

public class MSTDemo {
	
	public static void main(String[] args) {
		
		UndirectedWeightedGraph graph = new UndirectedWeightedGraph(6);
		
		graph.addEdge(0, 1, 1);
		graph.addEdge(0, 2, 2);
		graph.addEdge(0, 3, 7);
		graph.addEdge(1, 2, 3);
		graph.addEdge(1, 3, 5);
		graph.addEdge(2, 3, 2);
		graph.addEdge(2, 5, 2);
		graph.addEdge(3, 4, 3);
		graph.addEdge(3, 5, 1);
		graph.addEdge(4, 5, 4);
		
		MinimumSpanningTree mst = new MinimumSpanningTree();
		HashSet<Edge> solution= mst.getMinimumSpanningTree(graph);
		
		System.out.println(solution);
	}
}
