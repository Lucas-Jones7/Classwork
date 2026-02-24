
public class HumanPlayer implements Player {
	private String name;
	
	public HumanPlayer(String name) {
		this.name= name;	
	}
	
	@Override
	public void update(String event) {
		System.out.println("Human Player " + name + " received: " + event);
	}
	
	@Override
	public String getName() {
		return name;
	}
}


