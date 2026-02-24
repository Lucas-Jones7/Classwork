
public class Client {
	public static void main(String[] args) {
		PokerTable table = new PokerTable();
		
		Player p1 = new HumanPlayer("Henry");
		Player p2 = new HumanPlayer("Brae");
		Player p3 = new AIPlayer("Jasper");
		Player p4 = new AIPlayer("Magnus");
		Player p5 = new Spectator("Garret");
		Player p6 = new Spectator("Bode");
		Player p7 = new Dealer("Austin");
		Player p8 = new Dealer("Greame");
		
		table.addPlayer(p1);
		table.addPlayer(p2);
		table.addPlayer(p3);
		table.addPlayer(p4);
		table.addPlayer(p5);
		table.addPlayer(p6);
		table.addPlayer(p7);
		table.addPlayer(p8);
		
		table.startNewRound();
		
		table.playerFolds(p2);
		table.playerFolds(p4);
		
		table.playerWins(p1);
		
		table.removePlayer(p5);
		table.removePlayer(p6);
		
		table.startNewRound();
	}
}
