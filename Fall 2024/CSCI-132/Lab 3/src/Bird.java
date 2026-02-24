
public class Bird extends Animal{

	private int wingspan;
	
	public Bird(String species, double weight, String continent, int population, int wingspan) {
		super(species, weight, continent, population);
		this.wingspan = wingspan;
	}

	public int getWingSpan() {
		return this.wingspan;
	}
	
	public void makeSound() {
		System.out.println("The " + species + " goes " + getSound());
	}
}
