package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import Math;
	
	/**
	 * Parent class for entities designed to move on the farm grid.
	 */
	public class GridMover extends PolarMover
	{
		// Size of the entity in grid cells;
		// ie how many cells it should take up (and move between), regardless of pixel size.
		public var widthInGrid:int;	
		public var heightInGrid:int;
		
		// Current position in grid (if entity is more than one cell wide/tall, 
		// this is the position of the top left corner of the entity)
		public var col:int = 1;			
		public var row:int = 1;	
		
		// The speed that the entity moves between cells
		public var speed:Number;
		
		// Whether the entity is moving, or stationary
		public var moving:Boolean = false;
		
		// Direction in degrees; 0 is right, 90 is up. For moving.
		public var direction:Number;
		
		// Destination (when moving)
		public var destinationX:Number;
		public var destinationY:Number;		
		public var destinationCol:int;		
		public var destinationRow:int;
		
		public function GridMover(x:Number = 0, y:Number = 0) 
		{
			super(x, y);	
		}
		
		override public function update():void
		{
			// Move
			if (moving)
			{
				var distanceToDestination:Number;
				if (direction == 0 || direction == 180)
					distanceToDestination = Math.abs(x - destinationX);
				else	
					distanceToDestination = Math.abs(y - destinationY);
				if (distanceToDestination <= speed * FP.elapsed)
				{
					x = destinationX;
					y = destinationY;
					col = destinationCol;
					row = destinationRow;
					moving = false;
				}
				else
				{
					move(speed * FP.elapsed, direction);
				}
			}
			
			super.update();
		}
		
		/**
		 * Aligns the entity to the given grid cell (Moves them there instantly).
		 */
		public function alignToGrid(col:int, row:int):void
		{
			x = FarmGrid.GRID_POS.x + col * FarmGrid.CELL_WIDTH * widthInGrid - FarmGrid.CELL_WIDTH / 2 * widthInGrid;
			y = FarmGrid.GRID_POS.y + row * FarmGrid.CELL_HEIGHT * heightInGrid - FarmGrid.CELL_HEIGHT / 2 * heightInGrid;
			this.col = col;
			this.row = row;
		}
		
		/**
		 * @return	Whether the entity can move up in the grid, or not.
		 */
		public function canMoveUp():Boolean
		{
			if (row > 1)
				return true;
			else
				return false;
		}
		
		/**
		 * @return	Whether the entity can move down in the grid, or not.
		 */		
		public function canMoveDown():Boolean
		{
			if (row + (heightInGrid - 1) < FarmGrid.GRID_ROWS)
				return true;
			else
				return false;			
		}
		
		/**
		 * @return	Whether the entity can move left in the grid, or not.
		 */		
		public function canMoveLeft():Boolean
		{
			if (col > 1)
				return true;
			else 
				return false
		}
		
		/**
		 * @return	Whether the entity can move right in the grid, or not.
		 */		
		public function canMoveRight():Boolean
		{
			if (col + (widthInGrid - 1) < FarmGrid.GRID_COLS)
				return true;
			else 
				return false
		}		
		
	}

}