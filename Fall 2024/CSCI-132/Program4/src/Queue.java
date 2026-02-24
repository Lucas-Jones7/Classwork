// Lucas Jones & Henry Stickling
import java.util.LinkedList;
public class Queue {
   private LinkedList<Customer> vipQueue;
   private LinkedList<Customer> regularQueue;
   private int customersServed;
   private long totalWaitTime;
   public Queue() {
       vipQueue = new LinkedList<>();
       regularQueue = new LinkedList<>();
       customersServed = 0;
       totalWaitTime = 0;
   }
   public void addRegularCustomer(Customer customer) {
       regularQueue.addLast(customer);
       System.out.println("Added " + customer.getName() + " to the queue\n");
   }
   public void addVipCustomer(Customer customer) {
       vipQueue.addLast(customer);
       System.out.println("Added " + customer.getName() + " (VIP) to the queue\n");
   }
   public void viewCurrentQueue() {
       System.out.println("Current queue");
       System.out.println("-------------");
       vipQueue.forEach(c -> System.out.println(c.getName() + "(" + c.getOrder() + ")"));
       regularQueue.forEach(c -> System.out.println(c.getName() + "(" + c.getOrder() + ")"));
       System.out.println("\n");
   }
   public void serveNextCustomer() {
       Customer nextCustomer = !vipQueue.isEmpty() ? vipQueue.poll() : regularQueue.poll();
       if (nextCustomer != null) {
           long waitTime = (System.nanoTime() - nextCustomer.getEnterTime()) / 1_000_000_000;
           totalWaitTime += waitTime;
           customersServed++;
           System.out.println(nextCustomer.getName() + " has been served their " + nextCustomer.getOrder());
           System.out.println("Time spent in queue: " + waitTime + " seconds");
           System.out.println(nextCustomer.getName() + "'s review: " + getReview(waitTime) + "\n");
       }
   }
   private String getReview(long waitTime) {
       if (waitTime <= 15) return "⭐⭐⭐";
       else if (waitTime <= 45) return "⭐⭐";
       else return "⭐";
   }
   public void removeCustomerByName(String name) {
       Customer removedCustomer = null;
       for (int i = 0; i < vipQueue.size(); i++) {
           if (vipQueue.get(i).getName().equals(name)) {
               removedCustomer = vipQueue.remove(i);
               break;
           }
       }      
       if (removedCustomer == null) {
           for (int i = 0; i < regularQueue.size(); i++) {
               if (regularQueue.get(i).getName().equals(name)) {
                   removedCustomer = regularQueue.remove(i);
                   break;
               }
           }
       }     
       if (removedCustomer != null) {
           long waitTime = (System.nanoTime() - removedCustomer.getEnterTime()) / 1_000_000_000;
           System.out.println(removedCustomer.getName());
           System.out.println("Time spent in queue: " + waitTime + " seconds" + "\n");
       } else {
           System.out.println("Customer not found.");
       }
   }
   public void printStatistics() {
       double averageWaitTime = customersServed > 0 ? (double) totalWaitTime / customersServed : 0;
       System.out.printf("Average wait time: %.1f seconds%n", averageWaitTime);
       System.out.println("Customers served: " + customersServed + "\n");
   }
}
