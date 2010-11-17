package  
{
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class CashRice extends Rice
	{		
		public function CashRice(x:Number = 0, y:Number = 0)  
		{
			// Initialize entity
			super(x, y);			
			type = 'cash_rice';
			image = Image.createRect(Farm.CELL_WIDTH - 8, Farm.CELL_HEIGHT - 8, Colors.ORANGE);
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