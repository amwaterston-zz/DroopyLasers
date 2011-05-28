package
{
	import org.flixel.*;
 
	public class Bucket extends FlxSprite
	{
		public var fullness:int;
		
		public function Bucket(X:int, Y:int, SimpleGraphic:Class = null)
		{
			super(X, Y);
			loadGraphic(SimpleGraphic, true, false, 100, 500);
			this.offset = new FlxPoint(50, 25);
		}
	}
}