package  
{
	/**
	 * Configuration class that holds constants
	 */
	public class Config
	{
		/**
		 * Player variables
		 */
		public static const MAX_HAPPINESS:int = 10;
		public static const MIN_HAPPINESS:int = -10;	
		public static const HAPPINESS_AT_START:int = 0;
		public static const MONEY_AT_START:int = 0;
		
		/**
		 * Planting and harvest stuff
		 */
		public static const PLANTING_TIME_AT_START:int = 60;
		public static const HARVEST_TIME_AT_START:int = 1;
		
		/**
		 * Pests
		 */
		public static const SNAIL_RELEASE_TIME_AT_START:Number = 5;
		public static const SNAIL_RELEASE_CHANCE_AT_START:Number = 0.5;
		 
		/**
		 * Phases
		 */
		public static const YEAR_START_PHASE:int = 0;
		public static const PLANTING_PHASE:int = 1;
		public static const HARVEST_PHASE:int = 2;
		public static const YEAR_END_PHASE:int = 3;		
		
		public function Config() 
		{
			
		}
		
	}

}