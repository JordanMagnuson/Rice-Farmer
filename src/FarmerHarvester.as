package  
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.Alarm;
	
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
		
		// The inputChecker for the harvester class--if the player does not push the correct button in time, 
		public var harvestingInputChecker:InputChecker;
		
		// Sets an alarm for harvesting--if the player does not type the correct key before the alarm, then the planter moves on.
		public var harvestingAlarm:Alarm = new Alarm(GameController.harvestTime);
		
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
			
			// Initialize inputchecker.
			
			 harvestingInputChecker = new InputChecker(this, "Al your base are belong to us.");
			
		}
		
		override public function added():void
		{
			FP.world.add(harvestingInputChecker);
			addTween(harvestingAlarm, true);
			harvestingInputChecker.showRenderedText();
		}
		
		// Checks for correct input against the input at the top of the class. If the input is correct, the farmer moves on immediately, and the rice is harvested. If it is incorrect, then the alarm continues to run down and the farmer does not harvest. Farmer should move faster over areas with no rice. 
		// WARNING: DOES NOT ACCOUNT FOR TWO OF THE SAME LETTER IN A ROW.
		
		override public function update():void
		{
			if (!moving)
			{
				if (Farm.riceMatrix[row - 1][col - 1] == 'r' || Farm.riceMatrix[row - 1][col - 1] == '$')
				{
					if (justReachedDestination)
					{
						trace(row - 1);
						trace(col - 1);
						harvestingInputChecker.showRenderedText();
						harvestingAlarm.reset(GameController.harvestTime);
					}
					//trace(harvestingInputChecker.inputMatch());
					//trace(harvestingAlarm.remaining); 
					if (harvestingInputChecker.inputMatch())
					{
						harvestingInputChecker.fadeOldRenderedText();
						emptyCurrentSpace(); 
						advance();
					}
				}
				else
				{
					advance();
				}
			}
			super.update();
		}
		
		public function emptyCurrentSpace():void
		{
			var removeList:Array = [];
			if (Farm.riceMatrix[row - 1][col - 1] == 'r') 
			{
				GameController.money++;
				Farm.riceMatrix[row - 1][col - 1] = 0;
				FP.world.getClass(Rice, removeList);
				for (var r:Number = 0; r < removeList.length; r++)
				{
					if ((removeList[r].x == this.x) && (removeList[r].y == this.y))
					{
						FP.world.remove(removeList[r]);
					}
				}
			}
			if (Farm.riceMatrix[row - 1][col - 1] == '$') 
			{
				GameController.money = GameController.money + 2;
				Farm.riceMatrix[row - 1][col - 1] = 0;
				for (var s:Number = 0; r < removeList.length; r++)
				{
					if ((removeList[r].x == this.x) && (removeList[r].y == this.y))
					{
						FP.world.remove(removeList[r]);
					}
				}
			}	
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