import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

public class HashMapDemo {
	public static void main(String[] args) {
		
		HashMap<String, String> map = new HashMap<String, String>(); // creates new HashMap
		HashSet<String> set = new HashSet<String>(); // creates a new HashSet 
		// hash sets are a value mapped to a boolean
		
		set.add("First");
		set.add("Second");
		set.add("Third");
		set.add("Fourth");
		System.out.println(set.contains("Third"));
		System.out.println(set);
		
		map.put("Dallas", "Cowboys"); // map.put puts pair into hash map
		map.put("Phillidelphia", "Eagles");
		
		Set<String> keys = map.keySet(); // creates a new set of strings which are our keys
		for(String key: keys) {
			System.out.println(key + " " + map.get(key));
		}
		
		System.out.println(map.get("Seattle")); // example showing a null return due to Seattle not being in the hashmap
		System.out.println(map);
	}
}
