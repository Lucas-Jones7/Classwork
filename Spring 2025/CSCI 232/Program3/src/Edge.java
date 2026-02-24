// Lucas Jones & Henry Stickling

// Represents an edge between two actors connected by a movie
class Edge {
    private String actor1;
    private String actor2;
    private String movie;
    private int weight;

    public Edge(String actor1, String actor2, String movie) {
        this.actor1 = actor1;
        this.actor2 = actor2;
        this.movie = movie;
        this.weight = 1; 
    }

    // Getters
    public String getActor1() {
        return actor1;
    }

    public String getActor2() {
        return actor2;
    }

    public String getMovie() {
        return movie;
    }
    
    public int getWeight() {
    	return weight;
    }

    public String toString() {
        return actor1 + " - " + actor2 + " (" + movie + ")";
    }
    
    // Returns opposite actor
    public String getOther(String actor) {
    	if (actor.equals(actor1)) {
    		return actor2;
    	} else if (actor.equals(actor2)) {
    		return actor1;
    	} else throw new IllegalArgumentException("Actor not part of this edge: " + actor);
    	
    }
}