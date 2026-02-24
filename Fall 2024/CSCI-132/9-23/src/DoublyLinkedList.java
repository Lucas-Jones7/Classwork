import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.Scanner;

public class DoublyLinkedList {
	
	private Node head;
	private Node tail;
	
	private int size;
	
	public DoublyLinkedList() {
		this.head = null;
		this.tail = null;
		this.size = 0;
	}
	
		Scanner input = new Scanner(new FileReader("airports.txt"));{
			
			while(input.hasNext()) {
				String line = input.nextLine();
				String[] values = line.split(",");
				
				String code = values[0];
				String city = values[1];
				
				Node newNode = new Node(code, city);
				
				insert(newNode, this.size + 1);
				
			}
			
          } catch (FileNotFoundException e) {
        	  System.out.println("file not found");
          }
          
         public void insert(Node newNode, int n) {
        	 
         }
		
	
	
}
