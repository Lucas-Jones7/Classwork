
public class Customer {
    private String name;
    private Item[] cart;

    public Customer(String name, Item[] cart) {
        this.name = name;
        this.cart = cart;
    }

    public String getName() {
        return name;
    }

    public double getCartCost() {
        double totalCost = 0;
        for (Item item : cart) {
            totalCost += item.getPrice();
        }
        return totalCost;
    }

    public void applyDiscounts() {
        for (Item item : cart) {
            if (item.getPrice() >= 200) {
                double newPrice = item.getPrice() * 0.8; 
                item.setPrice(newPrice);
            }
        }
    }
}

