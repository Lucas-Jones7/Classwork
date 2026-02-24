
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
}