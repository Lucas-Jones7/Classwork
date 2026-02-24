public class Dealer implements Player {
	private String name;
	
	public Dealer(String name) {
		this.name= name;	
	}
	
	@Override
	public void update(String event) {
		System.out.println("Dealer " + name + " acknowledges: " + event);
	}
	
	@Override
	public String getName() {
		return name;
	}
}


