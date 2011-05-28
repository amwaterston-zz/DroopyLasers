package
{
	import org.flixel.*;
 
	public class Bucket extends FlxSprite
	{
		public function Bucket(X:int, Y:int)
		{
			super(X, Y);
			makeGraphic(10, 12, 0xffaa1111);
		}
	}
}