package  
{
	import adobe.utils.CustomActions;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Farm extends Entity
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
		
		// Matrices to keep track of cell states
		public static var dirtMatrix:Array = new Array();	// Keeps track of cells' dirt state (empty, mud, or $ for high-yield)
		public static var riceMatrix:Array = new Array();	// Keeps track of cells' rice state (empty, rice, hig-yield rice)
		
		public function Farm() 
		{
			layer = 10;
			Input.define("Generate", Key.G);
			Input.define("Clear", Key.C);
		}
		
		override public function added():void
		{
			generateFarmland();
		}
		
		/**
		 * Function which generates new farmland at the beginning of planting season.
		 */
		public function generateFarmland():void
		{		
			var colArray:Array = new Array();
			var x:int;
			var y:int;
			
			// Clear first
			clearFarmland();
			
			/**
			 * Generate mud and high-yield cash dirt
			 */
			for (var r:int = 1; r <= GRID_ROWS; r++)
			{
				colArray = [];
				y = getYFromRow(r);
				for (var c:int = 1; c <= GRID_COLS; c++)
				{					
					// 0 = empty (regular dirt)
					// m = mud (requires 2 keypresses)
					// $ = high-yield dirt
					x = getXFromCol(c);
					if (r == 1 && c == 1)
						colArray.push(0);		// First cell should always be empty (regular dirt)				
					else if (FP.random < 0.15)
					{
						colArray.push('m');
						FP.world.add(new Mud(x, y));
					}
					else if (FP.random < 0.15)
					{
						colArray.push('$');
						FP.world.add(new CashDirt(x, y));
					}
					else
						colArray.push(0);
				}
				dirtMatrix.push(colArray);
			}
			//trace('-----');
			//trace(dirtMatrix[0]);
			//trace(dirtMatrix[1]);
			//trace(dirtMatrix[2]);
			
			/**
			 * Generate empty rice matrix
			 */
			for (r = 1; r <= GRID_ROWS; r++)
			{
				colArray = [];
				for (c = 1; c <= GRID_COLS; c++)
				{					
					// 0 = empty (regular dirt)
					// r = rice
					// $ = high-yield rice			
					colArray.push(0);
				}
				riceMatrix.push(colArray);
			}			
			//trace('-----');
			//trace(riceMatrix[0]);
			//trace(riceMatrix[1]);
			//trace(riceMatrix[2]);			
		}
		
		/**
		 * Clears farmland of all mud, cash dirt, and rice.
		 */
		public function clearFarmland():void
		{
			// Clear matrices
			dirtMatrix = [];
			riceMatrix = [];
			
			// Remove mud, cash dirt, rice entities
			var removeList:Array = [];
			FP.world.getClass(Mud, removeList);
			FP.world.getClass(CashDirt, removeList);
			FP.world.getClass(Rice, removeList);
			for each (var e:Entity in removeList)
				FP.world.remove(e);	
		}		
		
		/**
		 * 
		 * @param	col		
		 * @return	Return center x value for the given column.
		 */
		public function getXFromCol(col:int):int
		{
			return GRID_POS.x + col * CELL_WIDTH - CELL_WIDTH / 2;
		}
		
		/**
		 * 
		 * @param	row		
		 * @return	Return center y value for the given row.
		 */
		public function getYFromRow(row:int):int
		{
			return GRID_POS.y + row * CELL_HEIGHT - CELL_HEIGHT / 2;
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
				if (r % 4 == 0)
					Draw.line(x1, y1, x2, y2, Colors.WHITE); 
				else if (r % 2 == 0)
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
				if (c % 4 == 0)
					Draw.line(x1, y1, x2, y2, Colors.WHITE); 
				else if (c % 2 == 0)
					Draw.line(x1, y1, x2, y2, Colors.BLACK); 
				else
					Draw.line(x1, y1, x2, y2, Colors.DARK_BROWN); 
			}			
			
			// Call super
			super.render();
		}	
		
		override public function update():void
		{
			if (Input.pressed("Generate"))
				generateFarmland();
			if (Input.pressed("Clear"))
				clearFarmland();				
				
			super.update();
		}
		
	}

}