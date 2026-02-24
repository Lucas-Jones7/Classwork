
public class Item {
    private String name;
    private double price;
    private double[] reviewScores;

    public Item(String name, double price, double[] reviewScores) {
        this.name = name;
        this.price = price;
        this.reviewScores = reviewScores;
    }

    public String getName() {
        return name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double newPrice) {
        this.price = newPrice;
    }

    public double getAverageRating() {
        double total = 0;
        for (double score : reviewScores) {
            total += score;
        }
        return total / reviewScores.length;
    }
}

