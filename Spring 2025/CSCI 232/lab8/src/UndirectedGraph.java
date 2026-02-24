import java.util.HashSet;
import java.util.LinkedList;

public class UndirectedGraph {

	private LinkedList<Integer>[] adjacencyList;
	private boolean[] visited;
	private int numEdges;
	
	public UndirectedGraph(int size) {
		adjacencyList = new LinkedList[size];
		visited = new boolean[getVertices()];
		for(int i = 0; i < adjacencyList.length; i++) {
			adjacencyList[i] = new LinkedList<Integer>();
		}
		
		numEdges = 0;
		
	}
	
	public void addEdge(int vertex1, int vertex2) {
		adjacencyList[vertex1].add(vertex2);
		adjacencyList[vertex2].add(vertex1);
		numEdges++;
	}
	
	public void printGraph() {
		
		for(int i = 0; i < adjacencyList.length; i++) {
			System.out.println(i + ": " + adjacencyList[i]);
		}
		
	}
	
	public void removeEdge(int vertex1, int vertex2) {
		
		if(adjacencyList[vertex2].contains(vertex1) && adjacencyList[vertex1].contains(vertex2)) {
		
			adjacencyList[vertex1].remove( (Integer) vertex2);
			adjacencyList[vertex2].remove( (Integer) vertex1);
			numEdges--;
		}
	}
	
	public LinkedList<Integer> getNeighbors(int vertex){
		return adjacencyList[vertex];
	}
	
	public int getDegree(int vertex) {
		return adjacencyList[vertex].size();
	}
	
	public int getEdges() {
		return this.numEdges;
	}
	
	public int getVertices() {
		return this.adjacencyList.length;
	}
	
	public void depthFirst(int n) {
		//System.out.println(n);
		visited[n] = true;
		for(int neighbor: getNeighbors(n)) {
			if(!visited[neighbor]) {
				depthFirst(neighbor);
			}
		}
	}
	
	public boolean isReachable(int vertex1, int vertex2) {
		depthFirst(vertex1);
		return visited[vertex2];
	}

	public void printConnectedComponents() {
		//TO DO: Lab 9
		boolean[] visited = new boolean[getVertices()];
		LinkedList<HashSet<Integer>> components = new LinkedList<>();
		
		for (int i = 0; i < getVertices(); i++) {
			if (!visited[i]) {
				HashSet<Integer> component = new HashSet<>();
				depthFirstCollect(i, visited, component); // DONT FORGET add depthFirstCollect method
				components.add(component);
			}
		}
		
		System.out.println("Connected Components: ");
		for (HashSet<Integer> component : components) {
			System.out.println(component);
		}
	}
		
		private void depthFirstCollect(int node, boolean[] visited, HashSet<Integer> component) {
			visited[node] = true;
			component.add(node);
			
			for (int neighbor: getNeighbors(node)) {
				if (!visited[neighbor]) {
					depthFirstCollect(neighbor, visited, component);
				}
			}
		}
}