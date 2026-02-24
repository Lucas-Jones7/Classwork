import java.util.HashSet;
import java.util.PriorityQueue;

public class MinimumSpanningTree {

	public HashSet<Edge> getMinimumSpanningTree(UndirectedWeightedGraph graph) {
		
		HashSet<Edge> mst = new HashSet<Edge>();
		//ccm = "Connected Component Marker"
		int[] ccm = new int[graph.getNumVertices()];
		for(int i = 0; i < ccm.length; i++) {
			ccm[i] = i;
		}
		
		PriorityQueue<Edge> edgeQueue = new PriorityQueue<>();
		for(Edge edge: graph.getEdges()) {
			edgeQueue.add(edge);
		}
		
		while(!edgeQueue.isEmpty()) {
			
			Edge edge = edgeQueue.poll();
			//make sure they dont create a cycle
			if(ccm[edge.getVertices()[0]]  != ccm[edge.getVertices()[1]]) {
				
				mst.add(edge);
				int newMarker = ccm[edge.getVertices()[0]];
				int oldMarker = ccm[edge.getVertices()[1]];
				
				for(int i = 0 ; i < ccm.length; i++) {
					if(ccm[i] == oldMarker) {
						ccm[i] = newMarker;
					}
				}
				
			}
			
		}
		return mst;
		
	}
	
}
