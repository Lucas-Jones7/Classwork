public class CarQueue {
    private Car[] queue;
    private int front, rear, size, capacity;
    private int carsServiced;
    private double totalEarnings;

    public CarQueue(int capacity) {
        this.capacity = capacity;
        this.queue = new Car[capacity];
        this.front = 0;
        this.rear = -1;
        this.size = 0;
        this.carsServiced = 0;
        this.totalEarnings = 0;
    }

    public void enqueue(Car newCar) {
        if (size == capacity) {
            System.out.println("Error: Queue is full - Cannot add " + newCar);
        } else {
            rear = (rear + 1) % capacity;
            queue[rear] = newCar;
            size++;
            System.out.println("Adding " + newCar + " to the queue");
        }
    }

    public void dequeue() {
        if (isEmpty()) {
            System.out.println("Queue is empty, cannot dequeue.");
        } else {
            Car car = queue[front];
            front = (front + 1) % capacity;
            size--;
            carsServiced++;
            if (car.isVIP()) {
                totalEarnings += 6;
            } else {
                totalEarnings += 10;
            }
            System.out.println("Car has been washed - Removing " + car + " from the queue");
        }
    }

    public Car peek() {
        if (isEmpty()) {
            System.out.println("Queue is empty, no car to peek at.");
            return null;
        }
        return queue[front];
    }

    public boolean isEmpty() {
        return size == 0;
    }

    public void printQueue() {
        if (isEmpty()) {
            System.out.println("Queue is empty.");
        } else {
            System.out.println("Current Car Wash Queue\n----------------------");
            for (int i = 0; i < size; i++) {
                int index = (front + i) % capacity;
                System.out.println((i + 1) + ". " + queue[index]);
            }
        }
    }

    public void printStats() {
        System.out.println("Car Wash Statistics\n-------------------");
        System.out.println("Number of cars serviced: " + carsServiced);
        System.out.println("Today's earnings: $" + totalEarnings);
    }
}
