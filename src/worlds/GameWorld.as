package worlds
{
	import net.flashpunk.Entity;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class GameWorld extends World
	{
		public static var farm:Farm;
		public static var phase:Entity;
		public static var hud:HUD;
		
		public function GameWorld() 
		{
			add(new Cheater);
			add(farm = new Farm);
			add(phase = new PlantingPhase);
			add(hud = new HUD);
			//add(new InputChecker("hello there"));
		}
		
	}

}