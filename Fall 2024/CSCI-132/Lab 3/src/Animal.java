
public class Animal {

	protected String species;
	protected double weight;
	protected String continent;
	protected int population;

	public Animal(String species, double weight, String continent, int population) {
		this.species = species;
		this.weight = weight;
		this.continent = continent;
		this.population = population;
		
	}
	public String getSpecies() {
		return this.species;
	}
	
	public double getWeight() {
		return this.weight;
	}
	
	public String getContinent() {
		return this.continent;
	}
	
	public int checkPopulation() {
		if (this.population < 2500) { 
			System.out.println("This animal is endangered!");
		}
		return this.population;
	}
	
	public String getSound() {
        String sound = null;

       
        if (species == "Congo Lion") {
            sound = "Roarrr!";
        } 
        
        else if (species == "Emperor Penguin") {
            sound = "chirp chirp chirp!";
        } 
        
        else if (species =="Axolotl") {
            sound = "Blub Blub!";
        }

        return sound;
    }

    public void makeSound() {
        System.out.println("The " + species + " goes " + getSound());
    }
	
}
