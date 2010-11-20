package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Draw;
	
	/**
	 * Static class that displays HUD info. Most of the actual info to display
	 * comes from the GameController class.
	 */
	public class HUD extends Entity
	{
		public static var moneyText:Text = new Text("Money: $######", Farm.GRID_POS.x, 50); 
		public static var happinessText:Text = new Text("Happiness: -##", 200, 50);
		public static var plantingTimerText:Text = new Text("Time: ##", 400, 50);
		
		public static var happinessBoostText:Text = new Text("To boost your happiness, type: '#######'", Farm.GRID_POS.x, 500);
		[Embed(source = '../assets/fonts/CasualEncounter.ttf', embedAsCFF="false", fontFamily = 'CasualEncounter')] private var CasualEncounter:Class;
		
		public function HUD() 
		{
			//moneyText.font = 'CasualEncounter';
			//moneyText.size = 8;
		}
		
		override public function update():void
		{
			moneyText.text = String("Money: $" + GameController.money);
			happinessText.text = String("Hapiness: " + GameController.happiness);
			plantingTimerText.text = String("Time: " + PlantingPhase.plantingAlarm.remaining);
			happinessBoostText.text = String("To boost your happiness, type: '" + GameController.happyBoostString + "'");
			super.update();
		}
		
		override public function render():void
		{
			Draw.graphic(moneyText);
			Draw.graphic(happinessText);
			Draw.graphic(plantingTimerText);
			Draw.graphic(happinessBoostText);
			super.render();
		}
	}
}