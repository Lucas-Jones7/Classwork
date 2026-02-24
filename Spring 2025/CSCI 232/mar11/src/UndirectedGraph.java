import java.util.LinkedList;

public class UndirectedGraph {
	
	private LindedList[] adjList;
	private int verticies;

	public UndirectedGraph(int vertices) {
		this.adjList = new LindedList[verticies];
		
		for(int i = 0; i < adjList.length; i++) {
			adjList[i] = new LinkedList<Integer>();
		}
	}
	
	public void addEdge(int vertex1, int vertex2) {
		adjList[vertex1].add(vertex2);
		adjList[vertex2].add(vertex1);
	}

	public void printGraph() {
		// TODO Auto-generated method stub
		
	}
}
