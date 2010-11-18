package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class TextEntity extends Entity
	{
		public var text:Text;
		public var bg:Image;
		
		[Embed(source = '../assets/fonts/CasualEncounter.ttf', embedAsCFF="false", fontFamily = 'CasualEncounter')] private var CasualEncounter:Class;
		
		public function TextEntity(textString:String, x:Number = 0, y:Number = 0) 
		{
			super(x, y);
			layer = -100;
			x = 400;
			y = 500;		
			text = new Text(textString, x, y);
			text.font = 'CasualEncounter';
			text.size = 8;
			
			// Initialize text rendering
			text.originX = text.width / 2;
			text.originY = text.height / 2;
			text.x = -text.originX;
			text.y = -text.originY;		
			text.color = Colors.BLACK;
			
			// Initialize background rendering
			bg = Image.createRect(text.width, text.height, Colors.WHITE);
			bg.originX = bg.width / 2;
			bg.originY = bg.height / 2;
			bg.x = -bg.originX;
			bg.y = -bg.originY;					
			
			setHitbox(text.width, text.height, text.originX, text.originY);		
			graphic = text;						
		}
		
		override public function render():void
		{
			Draw.graphic(bg, x, y);
			super.render();
		}
		
		public function fadeIn():void
		{
			
		}
		
		public function fadeOut():void
		{
			
		}
		
	}

}