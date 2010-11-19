package  
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import worlds.GameWorld;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Cheater extends Entity
	{
		public static var enabled:Boolean = false;
		
		public function Cheater() 
		{
			Input.define("Restart", Key.F1);
			Input.define("Generate", Key.F2);
		}
		
		public static function enable():void
		{
			enabled = true;
		}
		
		override public function update():void
		{
			if (enabled)
			{
				if (Input.pressed("Restart"))
				{
					FP.world = new GameWorld;
				}
				if (Input.pressed("Generate"))
					GameWorld.farm.generateFarmland();
				//if (Input.pressed("Clear"))
					//GameWorld.farm.clearFarmland();
			}
		}
		
	}

}