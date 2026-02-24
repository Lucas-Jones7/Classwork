
public class Amphibian extends Animal{
	
	private String diet;

	public Amphibian(String species, double weight, String continent, int population, String diet) {
		super(species, weight, continent, population);	
		this.diet = diet;
	}
	
	public String getDiet() {
		return this.diet;
	}
	
	public void makeSound() {
		System.out.println("The " + species + " goes " + getSound());
	}
	
}