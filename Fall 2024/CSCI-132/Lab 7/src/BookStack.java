import java.util.Arrays;

public class BookStack implements StackMethods {
	//TO Do: Instance Fields
    private Book[] stack;
    private int size;

    //TO Do: Constructor
    public BookStack(int capacity) {
        stack = new Book[capacity];
        size = 0;
    }

    //TO Do: Have your IDE add the unimplemented methods, and then fill in the bodies here
    public void push(Book newBook) {
        if (size == stack.length) {
            stack = Arrays.copyOf(stack, stack.length + 1);  
        }
        stack[size] = newBook;
        size++;
    }

    public Book pop() {
        if (isEmpty()) {
            return null; 
        }
        Book top = stack[size - 1];
        stack[size - 1] = null;  
        size--;
        return top;
    }

    public Book peek() {
        if (isEmpty()) {
            return null; 
        }
        return stack[size - 1];
    }

    public boolean isEmpty() {
        return size == 0;
    }

    public int getSize() {
        return size;
    }

    public void printStack() {
        for (int i = size - 1; i >= 0; i--) {
            System.out.println("-" + stack[i].getInfo());
        }
    }
}
