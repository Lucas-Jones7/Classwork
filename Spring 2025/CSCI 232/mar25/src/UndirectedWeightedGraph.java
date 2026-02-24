import java.util.HashSet;
import java.util.LinkedList;

public class UndirectedWeightedGraph {
	
	private LinkedList<Edge>[] adjacencyList;
	private HashSet<Edge> edges;
	
	public UndirectedWeightedGraph(int numVerticies) {
		this.adjacencyList = new LinkedList[numVerticies];
		
		for(int i = 0; i < adjacencyList.length; i++) {
			this.adjacencyList[i] = new LinkedList<Edge>();		
		}
		this.edges = new HashSet<>();
	}
	
	public void addEdge(int vertex1, int vertex2, int weight) {
		
		Edge edge = new Edge(vertex1, vertex2, weight);
		
		if(edges.add(edge)) {
			adjacencyList[vertex1].add(edge);
			adjacencyList[vertex2].add(edge);
		}
	}
	
	public HashSet<Edge> getEdges(){
		return this.edges;
	}
	
	public int getNumEdges() {
		return this.edges.size();
	}
	
	public int getNumVerticies() {
		return this.adjacencyList.length;
	}
}
