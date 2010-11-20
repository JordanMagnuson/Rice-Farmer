package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class InputChecker extends Entity
	{
		public var parentEntity:Entity;			// The rendered text will always appear at the location of the parent entity.
		public var controllerString:String;
		public var currentIndex:int = 0;
		public var currentChar:String;
		
		// Whether the controllerString has been typed in full.
		public var complete:Boolean = false;
		
		// Rendered text
		public var renderedText:TextEntity;		// Holds the current renedred text (to show).
		public var oldRenderedText:TextEntity;	// Holds the last rendered text (to fade).		
		
		public function InputChecker(parentEntity:Entity, controllerString:String) 
		{
			layer = -100;
			this.parentEntity = parentEntity;
			this.controllerString = controllerString;
			currentIndex = 0;
			currentChar = controllerString.charAt(0);
			
			// Initialize rendering of text
			//updateRenderedText();
			//x = 400;
			//y = 500;
		}
		
		public function updateRenderedText():void
		{
			//oldRenderedText = renderedText;
			//x = parentEntity.x;
			//y = parentEntity.y;
			//renderedText = new Text(currentChar);
			//renderedText.color = Colors.BLACK;
			//renderedText.originX = renderedText.width / 2;
			//renderedText.originY = renderedText.height / 2;
			//renderedText.x = -renderedText.originX;
			//renderedText.y = -renderedText.originY;		
			//setHitbox(renderedText.width, renderedText.height, renderedText.originX, renderedText.originY);	
			//renderedText.alpha = 0;
			//graphic = renderedText;
		}
		
		public function fadeOldRenderedText():void
		{
			oldRenderedText = renderedText;
			FP.world.remove(oldRenderedText);
		}
		
		public function showRenderedText():void
		{
			x = parentEntity.x;
			y = parentEntity.y;
			renderedText = new TextEntity(currentChar, x, y);
			FP.world.add(renderedText);
		}
		
		/**
		 * @return	True if the last text entered by the player matches the current character in the controller string.
		 */
		public function inputMatch():Boolean
		{
			// If input matches...
			if (Input.keyString.charAt(Input.keyString.length - 1) == currentChar)
			{
				// Advance index, or wrap through controllerString if at end.
				if (currentIndex == controllerString.length - 1)
				{
					trace('complete');
					complete = true;
					currentIndex = 0;
				}
				else
					currentIndex++;
				currentChar = controllerString.charAt(currentIndex);
				//updateRenderedText();
				//fadeOldRenderedText();
				return true;
			}
			// If input does not match...
			else
				return false;
		}
	}

}