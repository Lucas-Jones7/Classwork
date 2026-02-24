public class Spectator implements Player {
	private String name;
	
	public Spectator(String name) {
		this.name= name;	
	}
	
	@Override
	public void update(String event) {
		System.out.println("Spectator " + name + " sees: " + event);
	}
	
	@Override
	public String getName() {
		return name;
	}
}


