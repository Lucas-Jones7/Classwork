public class Car {
    private String makeModel;
    private String owner;
    private boolean isVIP;

    public Car(String makeModel, String owner, boolean isVIP) {
        this.makeModel = makeModel;
        this.owner = owner;
        this.isVIP = isVIP;
    }

    public boolean isVIP() {
        return isVIP;
    }

    @Override
    public String toString() {
        return makeModel + " (" + owner + ")";
    }
}
