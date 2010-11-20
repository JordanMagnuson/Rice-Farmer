package  
{
	import net.flashpunk.FP;
	
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
		public static var plantingTime:Number = Config.PLANTING_TIME_AT_START;
		
		/**
		 * Time player gets to harvest one cell, in seconds.
		 */
		public static var harvestTime:Number = Config.HARVEST_TIME_AT_START;
		
		/**
		 * Player variables
		 */
		public static var money:int = Config.MONEY_AT_START;
		public static var happiness:int = Config.HAPPINESS_AT_START;
		
		/**
		 * Current array and string that needs to be typed to boost happiness.
		 */
		public static var happyBoostArray:Array = new Array("sing", "rest", "relax", "snooze", "tea", "break");
		public static var happyBoostString:String = happyBoostArray[FP.rand(happyBoostArray.length)];
		
		public function GameController() 
		{
			
		}
		
		public static function setNewHappyBoostString():void
		{
			var oldString:String = happyBoostString;
			do	// This loop makes sure that we never choose the same string twice in a row.
			{
				happyBoostString = happyBoostArray[FP.rand(happyBoostArray.length)];
			}
			while (oldString == happyBoostString);
		}
		
	}

}