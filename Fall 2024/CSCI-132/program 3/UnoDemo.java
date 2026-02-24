// Henry Stickling & Lucas Jones
import java.util.*;
public class UnoDemo {
   public static void main(String[] args) {
       List<Card> hand = new ArrayList<>();
       CardStack drawPile = new CardStack();
       CardStack discardPile = new CardStack();
       // Add cards to the draw pile
       initializeDrawPile(drawPile);
       // Draw the initial hand and move top card to the discard pile
       for (int i = 0; i < 6; i++) {
           hand.add(drawPile.pop());
       }
       discardPile.push(drawPile.pop());
       
       boolean gameOver = false;
       Scanner scanner = new Scanner(System.in);
       boolean saidUno = false;  // Tracker for if player entered UNO
       while (!gameOver) {
           UnoPrinter.printGame(hand, discardPile.peek(), drawPile.peek(), drawPile.size());
           if (hand.size() == 1 && !saidUno) {
               System.out.println("Enter the number of the card from your hand you wish to play: ");
               String input = scanner.nextLine().trim();
               if (input.equalsIgnoreCase("UNO")) {    // Checks if UNO was entered
                   saidUno = true;
               } else {
                   System.out.println("You forgot to say UNO!! You Lose!");
                   break;
               }
           }
           System.out.println("Enter the number of the card from your hand you wish to play: ");
           String input = scanner.nextLine().trim();
           if (playCard(input, hand, discardPile, drawPile)) {
               gameOver = checkWinCondition(hand, drawPile);
           }
       }
       scanner.close();
   }
   private static void initializeDrawPile(CardStack drawPile) {
       String[] colors = {"R", "B", "G"};
       char[] values = {'D', 'D', 'W', '1', '2', '3', '4'};
       for (String color : colors) {
           for (char value : values) {
               drawPile.push(new Card(color.charAt(0), value));
           }
       }
       Collections.shuffle(drawPile.getCards());
   }
   private static boolean playCard(String input, List<Card> hand, CardStack discardPile, CardStack drawPile) {
       try {
           int cardIndex = Integer.parseInt(input) - 1;
           Card selectedCard = hand.get(cardIndex);
           if (isLegalMove(selectedCard, discardPile.peek())) {
               hand.remove(cardIndex);
               discardPile.push(selectedCard);
               // Draw penalty for draw 2
               if (selectedCard.getValue() == 'D') {
                   drawCards(hand, drawPile, 2);
               }
               return true;
           } else {
               System.out.println("You cannot play the card " + selectedCard + " on the card " + discardPile.peek());
               return false;
           }
       } catch (NumberFormatException | IndexOutOfBoundsException e) {
           System.out.println("Invalid input. Please enter a valid card number.");
           return false;
       }
   }
   private static boolean isLegalMove(Card selectedCard, Card topCard) {
       return selectedCard.getColor() == topCard.getColor() || selectedCard.getValue() == topCard.getValue() || selectedCard.getValue() == 'W';
   }
   private static void drawCards(List<Card> hand, CardStack drawPile, int count) {
       for (int i = 0; i < count && !drawPile.isEmpty(); i++) {
           hand.add(drawPile.pop());
       }
   }
   private static boolean checkWinCondition(List<Card> hand, CardStack drawPile) {
       if (hand.isEmpty()) {
           System.out.println("Congratulations, you won!");
           return true;
       }
       if (drawPile.isEmpty() && !hasPlayableCard(hand, drawPile.peek())) {
           System.out.println("You Lose!");
           return true;
       }
       return false;
   }
   private static boolean hasPlayableCard(List<Card> hand, Card topCard) {
       for (Card card : hand) {
           if (isLegalMove(card, topCard)) {
               return true;
           }
       }
       return false;
   }
}
