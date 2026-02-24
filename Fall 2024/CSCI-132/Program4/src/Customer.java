// Lucas Jones & Henry Stickling
public class Customer {
   private String name;
   private String order;
   private long enterTime;
   public Customer(String name, String order, long enterTime) {
       this.name = name;
       this.order = order;
       this.enterTime = enterTime;
   }
   public String getName() {
   	return name;
   	}
   public String getOrder() {
   	return order;
   	}
   public long getEnterTime() {
   	return enterTime;
   	}
}
