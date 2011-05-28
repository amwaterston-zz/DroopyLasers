package
{
	import org.flixel.*;
 
	public class Bucket extends FlxSprite
	{
		public var fullness:int;
		
		public function Bucket(X:int, Y:int)
		{
			super(X, Y);
			makeGraphic(20, 24, 0xffaa1111);
		}
	}
}