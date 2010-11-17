package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class CashDirt extends Entity
	{			
		// Graphic
		public var image:Image = Image.createRect(Farm.CELL_WIDTH - 8, Farm.CELL_HEIGHT - 8, Colors.GREEN);
		
		public function CashDirt(x:Number = 0, y:Number = 0)  
		{
			// Initialize entity
			super(x, y);			
			type = 'mud';
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