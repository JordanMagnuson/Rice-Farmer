package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.FP;
	import worlds.GameWorld;
	
	/**
	 * Static entity which governs the planting phase.
	 */
	public class PlantingPhase extends Entity
	{
		// Start the alarm when the player plants the first cell.
		public static var started:Boolean = false;
		
		// Keeps track of how long the player has to plant the ENTIRE FIELD.
		public static var plantingAlarm:Alarm;
		
		public static var snailReleaseAlarm:Alarm = new Alarm(GameController.snailReleaseTime, releaseSnail);
		
		// The player's avatar during the planting phase.
		public static var farmerPlanter:FarmerPlanter;
		
		public function PlantingPhase() 
		{
			plantingAlarm = new Alarm(GameController.plantingTime, endPhase);
		}
		
		override public function added():void
		{
			FP.world.add(farmerPlanter = new FarmerPlanter);
			farmerPlanter.alignToGrid(1, 1);
			//FP.world.add(displayTimer = new DisplayTimer(400, 50, plantingAlarm));
			plantingAlarm.reset(GameController.plantingTime);
			addTween(plantingAlarm);	
		}
		
		override public function update():void
		{
			super.update();
		}
		
		public static function start():void
		{
			plantingAlarm.start();
			started = true;
		}
		
		public static function releaseSnail():void
		{
			trace('snail released!');
		}
		
		public function endPhase():void
		{
			// Remove all planting-phase-specific entities
			trace("planting phase over!");
			var removeList:Array = new Array();
			FP.world.getClass(TextEntity, removeList);
			for each (var e:Entity in removeList)
				FP.world.remove(e);				
			FP.world.remove(farmerPlanter);
			FP.world.add(GameWorld.phase = new HarvestPhase);
			FP.world.remove(this);
		}
		
	}

}