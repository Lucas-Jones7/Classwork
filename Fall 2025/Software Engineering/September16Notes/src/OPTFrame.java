import java.time.DayOfWeek;
import java.time.LocalDate;

public class OPTFrame {

	public OPTFrame() {
		human.derek
	}
	
	public class human() {
		
	}
	
	public class Website() {
	
		public boolean isTodayFridayTheThirteenth() {
			LocalDate now = LocalDate.now();
			if (LocalDate.now().getDayOfWeek() == DayOfWeek.FRIDAY && LocalDate.now().getDayOfMonth() == 13) {
				return true;
			}
			return false;
		}
	}
}
