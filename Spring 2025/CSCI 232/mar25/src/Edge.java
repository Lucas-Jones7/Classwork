
public class Edge implements Comparable<Edge> {
	
	private int vertex1;
	private int vertex2;
	
	private int weight;
	
	public Edge(int v1, int v2, int w) {
		this.vertex1 = v1;
		this.vertex2 = v2;
		this.weight = w;
	}
	
	public int[] getVerticies() {
		return new int[] {vertex1, vertex2};
	}
	
	public int getWeight() {
		return this.weight;
	}
	
	public String toString() {
		return "(" + vertex1 + "," + vertex2 + ")";
	}
	
	public boolean equals(Object other) {
		
		if(! (other instanceof Edge)) {
			return false;
		}
		
		Edge otherEdge = (Edge) other;
		
		if((vertex1 == otherEdge.vertex1 && vertex2 == otherEdge.vertex2) || vertex1 == otherEdge.vertex2 && vertex2 == otherEdge.vertex1) {
			return true;
		}
		
		return false;
	}
	
	@Override
	public int compareTo(Edge otherEdge) {
		if(weight < otherEdge.weight) {
			return -1;
		} else if(weight > otherEdge.weight) {
			return 1;
		}else {
			return 0;
		}
	}
}
