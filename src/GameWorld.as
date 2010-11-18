package  
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class GameWorld extends World
	{
		public static var farm:Farm;
		public static var farmerPlanter:FarmerPlanter;
		
		public function GameWorld() 
		{
			add(new Cheater);
			add(farm = new Farm);
			add(farmerPlanter = new FarmerPlanter);
			//add(new InputChecker("hello there"));
		}
		
	}

}