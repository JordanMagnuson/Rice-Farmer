package  
{
	/**
	 * Static class to keep track of game elements like level and planting phase, etc.
	 */
	public class GameController
	{
		/**
		 * Level starts at 1, increases at each year_start
		 */
		public static var level:int;
		
		/**
		 * Phases:
		 * 0: year_start
		 * 1: planting
		 * 2: harvest
		 * 3: year_end
		 */
		public static var phase:int;
		
		/**
		 * Time player gets to plant, in seconds.
		 */
		public static var plantingTime:Number = 30;
		
		/**
		 * Time player gets to harvest one cell, in seconds.
		 */
		public static var harvestTime:Number = 1;
		
		/**
		 * Player variables
		 */
		public static var money:int = 50;
		public static var happiness:int = 50;
		
		public function GameController() 
		{
			
		}
		
	}

}