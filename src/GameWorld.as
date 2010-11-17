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
		public static var player:Player;
		
		public function GameWorld() 
		{
			add(new FarmGrid);
			add(player = new Player());
		}
		
	}

}