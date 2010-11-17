package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Draw;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class FarmGrid extends Entity
	{
		// Grid size constants
		public static const GRID_POS:Point = new Point(30, 30);	// Location of top left corner	
		public static const GRID_COLS:int = 16;		
		public static const GRID_ROWS:int = 12;
		public static const CELL_WIDTH:int = 40;	// Width in pixels
		public static const CELL_HEIGHT:int = 40;	// Height in pixels		
		
		// Calculated constants - don't change
		public static const GRID_HEIGHT:int = GRID_ROWS * CELL_HEIGHT;
		public static const GRID_WIDTH:int = GRID_COLS * CELL_WIDTH;
		
		public function FarmGrid() 
		{
			layer = 1;
		}
		
		public function getRowFromY(y:int):int
		{
			return 1;
		}
		
		public function getColFromX(x:int):int
		{
			return 1;
		}
		
		/**
		 * Render the grid.
		 */
		override public function render():void 
		{
			// Draw background rectangle for entire grid
			Draw.rect(GRID_POS.x, GRID_POS.y, GRID_COLS * CELL_WIDTH, GRID_ROWS * CELL_HEIGHT, Colors.LIGHT_BROWN);
			
			// Draw grid lines
			for (var r:int; r <= GRID_ROWS; r++)
			{		
				var x1:int = GRID_POS.x;
				var x2:int = GRID_POS.x + GRID_WIDTH;
				var y1:int = GRID_POS.y + r * CELL_HEIGHT;
				var y2:int = y1;
				if (r % 2 == 0)
					Draw.line(x1, y1, x2, y2, Colors.BLACK); 
				else
					Draw.line(x1, y1, x2, y2, Colors.DARK_BROWN); 
			}
			for (var c:int; c <= GRID_COLS; c++)
			{
				x1 = GRID_POS.x + c * CELL_WIDTH;
				x2 = x1;
				y1 = GRID_POS.y;
				y2 = GRID_POS.y + GRID_HEIGHT;
				if (c % 2 == 0)
					Draw.line(x1, y1, x2, y2, Colors.BLACK); 
				else
					Draw.line(x1, y1, x2, y2, Colors.DARK_BROWN); 
			}			
			
			// Call super
			super.render();
		}	
		
	}

}