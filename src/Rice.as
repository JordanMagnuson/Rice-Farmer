package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Rice extends Entity
	{			
		// Graphic
		public var image:Image = Image.createRect(Farm.CELL_WIDTH - 8, Farm.CELL_HEIGHT - 8, Colors.YELLOW);
		
		public function Rice(x:Number = 0, y:Number = 0)  
		{
			// Initialize entity
			super(x, y);			
			type = 'rice_plant';
			graphic = image;
			layer = 1;
			
			// Initialize image, hitbox
			image.originX = image.width / 2;
			image.originY = image.height / 2;
			image.x = -image.originX;
			image.y = -image.originY;		
			setHitbox(image.width, image.height, image.originX, image.originY);	
			
		}
		
	}

}