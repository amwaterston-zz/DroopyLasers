package
{
	import org.flixel.*;
 
	public class Bucket extends FlxSprite
	{
		public function Bucket(X:int, Y:int)
		{
			super(X, Y);
			makeGraphic(20, 24, 0xffaa1111);
		}
	}
}