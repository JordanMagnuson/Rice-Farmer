package  
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class FarmerHarvester extends GridMover
	{
		
		// Graphic
		public var image:Image = Image.createRect(Farm.CELL_WIDTH - 12, Farm.CELL_HEIGHT - 12, Colors.RED);
		
		// Whether we are currently moving up or down a column on the harvest path.
		public var harvestingDirection:String = 'down';
		
		public function FarmerHarvester(x:Number = 0, y:Number = 0) 
		{
			// Initialize entity
			super(x, y);			
			type = 'farmer_planter';
			graphic = image;
			layer = 0;		
			
			// Initialize image, hitbox
			image.originX = image.width / 2;
			image.originY = image.height / 2;
			image.x = -image.originX;
			image.y = -image.originY;		
			setHitbox(image.width, image.height, image.originX, image.originY);		
			
			// Grid information
			widthInGrid = 1;
			heightInGrid = 1;
			speed = 100;	
			
			// Define controls
			Input.define("Space", Key.SPACE);	
			
		}
		
		override public function update():void
		{
			if (!moving && Input.check("Space"))
			{
				advance();
			}
			
			super.update();
		}
		
		/**
		 * Advances the harvester along the harvest path.
		 */
		public function advance():void
		{
			if (harvestingDirection == 'down')
			{
				if (canMoveDown())
				{
					 moveDown();
				}
				else if (canMoveRight())
				{
					 moveRight();
					 harvestingDirection = 'up';
				}
			}
			else if (harvestingDirection == 'up')
			{
				if (canMoveUp())
				{
					 moveUp();
				}
				else if (canMoveRight())
				{
					 moveRight();
					 harvestingDirection = 'down';
				}
			}
		}
		
	}
}