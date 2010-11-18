package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class FarmerPlanter extends GridMover
	{	
		// Player graphic
		[Embed(source='../assets/graphics/farmer.png')] private const S_FARMER:Class;
		public var image:Image = new Image(S_FARMER);		
		
		// Input checker for planting
		public var myInputChecker:InputChecker;
		
		// After moving, the farmer must plant before moving again.
		public var canMove:Boolean = true;
		
		public function FarmerPlanter(x:Number = 0, y:Number = 0)  
		{	
			// Initialize entity
			super(x, y);			
			type = 'player';
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
			alignToGrid(1, 1);
			speed = 100;
			
			// Define controls
			Input.define("U", Key.UP);
			Input.define("D", Key.DOWN);			
			Input.define("L", Key.LEFT);	
			Input.define("R", Key.RIGHT);	
			
			Input.define("Plant", Key.P);
			
			// Input checker
			myInputChecker = new InputChecker(this, "..-,$%*&@#");
			
			
		}	
		
		override public function added():void
		{
			FP.world.add(myInputChecker);
		}
		
		/**
		 * Update.
		 */		
		override public function update():void 
		{
			if (justReachedDestination)
			{
				canMove = false;
				myInputChecker.showRenderedText();
			}
			
			// Check input
			if (!moving)
			{
				// Planting
				if (myInputChecker.inputMatch())
				{
					plant();
				}
				
				// Movement
				if (canMove)
				{
					if (Input.check("U") && canMoveUp())
					{
						moving = true;
						direction = 90;
						destinationX = x;
						destinationY = y - Farm.CELL_HEIGHT * heightInGrid;
						destinationCol = col;				
						destinationRow = row - heightInGrid;
					}
					else if (Input.check("D") && canMoveDown())
					{
						moving = true;
						direction = 270;
						destinationX = x;
						destinationY = y + Farm.CELL_HEIGHT * heightInGrid;
						destinationCol = col;				
						destinationRow = row + heightInGrid;
					}
					else if (Input.check("L") && canMoveLeft())
					{
						moving = true;
						direction = 180;
						destinationX = x - Farm.CELL_WIDTH * widthInGrid ;
						destinationY = y;
						destinationCol = col - widthInGrid;				
						destinationRow = row;
					}
					else if (Input.check("R") && canMoveRight())
					{
						moving = true;
						direction = 0;
						destinationX = x + Farm.CELL_WIDTH * widthInGrid ;
						destinationY = y;
						destinationCol = col + widthInGrid;				
						destinationRow = row;
					}
				}
			}
			super.update();
		}	
		
		public function plant():void
		{	
			// Cash rice
			if (Farm.dirtMatrix[row - 1][col - 1] == '$')
			{
				FP.world.add(new CashRice(x, y));			// Add cash rice entity
				Farm.riceMatrix[row - 1][col - 1] = '$';	// Update rice matrix
			}
			// Regular rice
			else											
			{
				FP.world.add(new Rice(x, y));				// Add rice entity
				Farm.riceMatrix[row - 1][col - 1] = 'r';	// Update rice matrix				
			}
			
			// Allow player to move again
			canMove = true;
		}		
		
		/**
		 * @return	Whether the entity can move up in the grid, or not.
		 */
		override public function canMoveUp():Boolean
		{
			if (row <= 1)										// On top row.
				return false;
			else if (Farm.riceMatrix[row - 2][col - 1] != 0)	// Rice above.
				return false;
			else
				return true;
		}
		
		/**
		 * @return	Whether the entity can move down in the grid, or not.
		 */		
		override public function canMoveDown():Boolean
		{
			if (row >= Farm.GRID_ROWS)							// On bottom row
				return false;
			else if (Farm.riceMatrix[row][col - 1] != 0)		// Rice below
				return false;
			else
				return true;			
		}
		
		/**
		 * @return	Whether the entity can move left in the grid, or not.
		 */		
		override public function canMoveLeft():Boolean
		{
			if (col <= 1)										// On Left-most column
				return false;
			else if (Farm.riceMatrix[row - 1][col - 2] != 0)	// Rice to left
				return false;
			else 
				return true;
		}
		
		/**
		 * @return	Whether the entity can move right in the grid, or not.
		 */		
		override public function canMoveRight():Boolean
		{
			if (col >= Farm.GRID_COLS)							// On right-most column
				return false;
			else if (Farm.riceMatrix[row - 1][col] != 0)		// Rice to Right
				return false;
			else 
				return true;
		}				
		
	}

}