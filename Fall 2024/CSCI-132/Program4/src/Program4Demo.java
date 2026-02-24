// Lucas Jones & Henry Stickling
import java.util.Scanner;
public class Program4Demo {
   private static Queue queue = new Queue();
   private static Scanner scanner = new Scanner(System.in);
   public static void main(String[] args) {
       System.out.println("Welcome to the Pizzeria Queue!");
       while (true) {
           printMenu();
           int choice = scanner.nextInt();
           scanner.nextLine();
           switch (choice) {
               case 1 -> queue.viewCurrentQueue();
               case 2 -> addCustomer(false);
               case 3 -> addCustomer(true);
               case 4 -> queue.serveNextCustomer();
               case 5 -> removeCustomer();
               case 6 -> queue.printStatistics();
               case 7 -> exitProgram();
               default -> System.out.println("Invalid choice. Try again.");
           }
       }
   }
   private static void printMenu() {
       System.out.println("""
           1. View current queue
           2. Add regular customer to queue
           3. Add VIP customer to queue
           4. Serve next customer
           5. Remove customer from queue
           6. Print queue statistics
           7. Exit\n
           Please enter an option""");
   }
   private static void addCustomer(boolean isVip) {
       System.out.print("What is the customer's name? ");
       String name = scanner.nextLine();
       System.out.print("What would you like to order? ");
       String order = scanner.nextLine();
       long enterTime = System.nanoTime();
       Customer customer = new Customer(name, order, enterTime);
       if (isVip) queue.addVipCustomer(customer);
       else queue.addRegularCustomer(customer);
   }
   private static void removeCustomer() {
       System.out.print("What customer is leaving the line? ");
       String name = scanner.nextLine();
       queue.removeCustomerByName(name);
   }
   private static void exitProgram() {
       System.out.println("Closing the pizzeria...");
       scanner.close();
       System.exit(0);
   }
}
