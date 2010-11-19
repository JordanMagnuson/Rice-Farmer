package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.FP;
	
	/**
	 * Entity which governs the harvest phase.
	 */
	public class HarvestPhase extends Entity
	{
		// Don't start timing each plant until after the first cell
		public static var started:Boolean = false;
		
		// Tracks how much time the player has to plant EACH CELL.
		public static var harvestAlarm:Alarm
		
		// The player's avatar during the planting phase.
		public static var farmerHarvester:FarmerHarvester;		
		
		public function HarvestPhase() 
		{
			harvestAlarm = new Alarm(GameController.harvestTime, endPhase);
			addTween(harvestAlarm);
		}
		
		override public function update():void
		{
			super.update();
		}
		
		public static function start():void
		{
			started = true;
		}		
		
		override public function added():void
		{
			FP.world.add(farmerHarvester = new FarmerHarvester);
			farmerHarvester.alignToGrid(1, 1);
		}
		
		public function endPhase():void
		{
			
		}
		
	}

}