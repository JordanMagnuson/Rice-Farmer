package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Player extends GridMover
	{	
		// Player graphic
		[Embed(source='../assets/graphics/player.png')] private const S_PLAYER:Class;
		public var image:Image = new Image(S_PLAYER);			
		
		public function Player(x:Number = 0, y:Number = 0)  
		{	
			// Initialize entity
			super(x, y);			
			type = 'player';
			graphic = image;
			layer = 0;
			
			// Initialize image
			image.originX = image.width / 2;
			image.originY = image.height / 2;
			image.x = -image.originX;
			image.y = -image.originY;		
			
			// Grid information
			widthInGrid = 2;
			heightInGrid = 2;
			alignToGrid(1, 1);
			speed = 100;
			
			// Define controls
			Input.define("U", Key.UP, Key.W);
			Input.define("D", Key.DOWN, Key.S);			
			Input.define("L", Key.LEFT, Key.A);	
			Input.define("R", Key.RIGHT, Key.D);				
		}	
		
		/**
		 * Update the player.
		 */		
		override public function update():void 
		{
			// Check input
			if (!moving)
			{
				if (Input.check("U") && canMoveUp())
				{
					moving = true;
					direction = 90;
					destinationX = x;
					destinationY = y - FarmGrid.CELL_HEIGHT * heightInGrid;
					destinationCol = col;				
					destinationRow = row - heightInGrid;
				}
				else if (Input.check("D") && canMoveDown())
				{
					moving = true;
					direction = 270;
					destinationX = x;
					destinationY = y + FarmGrid.CELL_HEIGHT * heightInGrid;
					destinationCol = col;				
					destinationRow = row + heightInGrid;
				}
				else if (Input.check("L") && canMoveLeft())
				{
					moving = true;
					direction = 180;
					destinationX = x - FarmGrid.CELL_WIDTH * widthInGrid ;
					destinationY = y;
					destinationCol = col - widthInGrid;				
					destinationRow = row;
				}
				else if (Input.check("R") && canMoveRight())
				{
					moving = true;
					direction = 0;
					destinationX = x + FarmGrid.CELL_WIDTH * widthInGrid ;
					destinationY = y;
					destinationCol = col + widthInGrid;				
					destinationRow = row;
				}
			}
				
			super.update();
		}	
		
	}

}