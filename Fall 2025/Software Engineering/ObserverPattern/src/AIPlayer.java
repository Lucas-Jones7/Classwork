
public class AIPlayer implements Player {
	private String name;
	
	public AIPlayer(String name) {
		this.name = name;
	}
	
	@Override
	public void update(String event) {
		System.out.println("AI Player " + name + " processing event: " + event);	
	}
	
	@Override
	public String getName() {
		return name;
	}
}
