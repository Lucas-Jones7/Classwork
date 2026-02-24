import java.util.ArrayList;
import java.util.List;

public class PokerTable {
	private List<Player> players = new ArrayList<>();
	
	public void addPlayer(Player p) {
		players.add(p);
		notifyAllPlayers("Player joined: " + p.getName());

	}
	
	public void removePlayer(Player p) {
		players.remove(p);
		notifyAllPlayers("Player left: " + p.getName());
	}
	
	private void notifyAllPlayers(String event) {
		for (Player p : players) {
			p.update(event);
		}
	}
	
	public void startNewRound() {
		notifyAllPlayers("A new round has started");
	}
	
	public void playerFolds(Player p) {
		notifyAllPlayers(p.getName() + " has folded.");
	}
	
	public void playerWins(Player p) {
		notifyAllPlayers(p.getName() + " has won the round");
	}
}
