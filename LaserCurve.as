package
{
	import org.flixel.*;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.display.Shape;
	
	public class LaserCurve extends FlxSprite
	{
		protected var drawShape:Shape;
		public var location:FlxPoint;
		public var direction:Number;
		public var power:Number;

        function LaserCurve(location:FlxPoint) 
		{
			this.location = location;
			this.direction = 0;
			this.power = 10;
        }
		
        override public function draw():void 
		{
			if (power == 0)
				return;
				
            drawShape = new Shape();
			drawShape.graphics.lineStyle(1, 0xFFD700);

			var drad = (direction / 360) * 2 * 3.1415926535;
			var gravity = +9.8;
			var v:FlxPoint = new FlxPoint(Math.cos(drad) * power, Math.sin(drad) * power);
			var a:FlxPoint = new FlxPoint(0, 1);
			//FlxG.log("START");
			var c:FlxPoint = new FlxPoint(location.x, location.y);
			//drawShape.graphics.beginFill(0xFF99FF);
			drawShape.graphics.moveTo(location.x, location.y);
			for (var i:int = 0; i < 100; i++)
			{
				v.x += a.x;
				v.y += a.y;
				c.x += v.x;
				c.y += v.y;
				//FlxG.log(c.x + ", " + c.y);
	            drawShape.graphics.lineTo(c.x, c.y);
			}
			drawShape.graphics.endFill();
			FlxG.camera.buffer.draw(drawShape);		
        }

		public function passesThrough(point:FlxPoint):Boolean
		{
			var a:FlxPoint = new FlxPoint(0, 1);
			var v:FlxPoint = new FlxPoint(location.x + (a.x * point.x), location.y + (a.y * point.x));
			return true;
		}
		
		override public function update():void
		{
			super.update();
		}
    }
}