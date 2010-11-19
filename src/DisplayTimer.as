package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.tweens.misc.Alarm;
	
	/**
	 * NOT CURRENTLY BEING USED.
	 */
	public class DisplayTimer extends Entity
	{
		public var alarm:Alarm;
		public var text:Text;
		
		public function DisplayTimer(x:Number, y:Number, parentAlarm:Alarm) 
		{
			super(x, y);
			alarm = parentAlarm;
			text = new Text('haha', x, y);
			
			// Initialize text rendering
			text.originX = text.width / 2;
			text.originY = text.height / 2;
			text.x = -text.originX;
			text.y = -text.originY;		
			text.color = Colors.WHITE;
			
			graphic = text;
		}
		
		override public function update():void
		{
			text.text = String(PlantingPhase.plantingAlarm.remaining);
			super.update();
		}
		
		override public function render():void
		{
			super.render();
		}
		
	}

}