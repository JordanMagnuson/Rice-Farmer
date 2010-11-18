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
		public var colsCovered:Array;	// If widthInGrid is greater than 1 this will contain more than 1 col.
		public var rowsCovered:Array;	// If heightInGrid is greater than 1 this will contain more than 1 row.
		
		// The speed that the entity moves between cells
		public var speed:Number;
		
		// Whether the entity is moving, or stationary
		public var moving:Boolean = false;
		public var justReachedDestination:Boolean = false;	// Stays true for one cycle after reaching a new cell.
		
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
			if (justReachedDestination)
				justReachedDestination = false;
			
			// Move
			if (moving)
			{
				var distanceToDestination:Number;
				if (direction == 0 || direction == 180)
					distanceToDestination = Math.abs(x - destinationX);
				else	
					distanceToDestination = Math.abs(y - destinationY);
				
				// Reached destination cell
				if (distanceToDestination <= speed * FP.elapsed)
				{
					justReachedDestination = true;
					x = destinationX;
					y = destinationY;
					col = destinationCol;
					row = destinationRow;
					updateColsCovered();
					updateRowsCovered();
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
			x = Farm.GRID_POS.x + col * Farm.CELL_WIDTH * widthInGrid - Farm.CELL_WIDTH / 2 * widthInGrid;
			y = Farm.GRID_POS.y + row * Farm.CELL_HEIGHT * heightInGrid - Farm.CELL_HEIGHT / 2 * heightInGrid;
			this.col = col;
			this.row = row;
			updateColsCovered();
			updateRowsCovered();
		}
		
		public function updateColsCovered():void
		{
			colsCovered = [];
			for (var c:int = col; c < col + widthInGrid; c++)
				colsCovered.push(c);
		}
		
		public function updateRowsCovered():void
		{
			rowsCovered = [];
			for (var r:int = row; r < row + heightInGrid; r++)
				rowsCovered.push(r);
		}		
		
		/**
		 * @return	Whether the entity can move up in the grid, or not.
		 */
		public function canMoveUp():Boolean
		{
			if (row <= 1)
				return false;
			else	
				return true;
		}
		
		/**
		 * @return	Whether the entity can move down in the grid, or not.
		 */		
		public function canMoveDown():Boolean
		{
			if (row >= Farm.GRID_ROWS)
				return false;
			else
				return true;		
		}
		
		/**
		 * @return	Whether the entity can move left in the grid, or not.
		 */		
		public function canMoveLeft():Boolean
		{
			if (col <= 1)
				return false;
			else
				return true;
		}
		
		/**
		 * @return	Whether the entity can move right in the grid, or not.
		 */		
		public function canMoveRight():Boolean
		{
			if (col >= Farm.GRID_COLS)
				return false;
			else
				return true;
		}		
		
	}

}