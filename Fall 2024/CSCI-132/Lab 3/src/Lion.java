
public class Lion extends Animal {

	private int packsize;
	
	public Lion(String species, double weight, String continent, int population, int packsize) {
		super(species, weight, continent, population);
		this.packsize = packsize;
	}

	public int getPackSize() {
		return this.packsize;
	}
	
	public void makeSound() {
		System.out.println("The " + species + " goes " + getSound());
	}

}
