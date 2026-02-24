import java.util.LinkedList;
public class CardStack {
   private LinkedList<Card> stack;
   public CardStack() {
       stack = new LinkedList<>();
   }
   public void push(Card card) {
       stack.addFirst(card);
   }
   public Card pop() {
       if (isEmpty()) {
           throw new IllegalStateException("Cannot pop from an empty stack.");
       }
       return stack.removeFirst();
   }
   public Card peek() {
       if (isEmpty()) {
           throw new IllegalStateException("Cannot peek on an empty stack.");
       }
       return stack.getFirst();
   }
   public boolean isEmpty() {
       return stack.isEmpty();
   }
   public int size() {
       return stack.size();
   }
   public LinkedList<Card> getCards() {
       return stack;
   }
}
