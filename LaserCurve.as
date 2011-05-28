package
{
	import org.flixel.*;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.display.Shape;
	
	public class LaserCurve extends FlxSprite
	{
		protected var drawShape:Shape;
		protected var point:FlxPoint;
		protected var direction:Number;
		protected var power:Number;

        function LaserCurve(point:FlxPoint, direction:Number, power:Number) 
		{
			this.point = point;
			this.direction = direction;
			this.power = power;
        }

        override public function draw():void 
		{
            drawShape = new Shape();
            drawShape.graphics.lineStyle(1, 0x999999);

			var drad = (direction / 360) * 2 * 3.1415926535;
			var gravity = +9.8;
			var v:FlxPoint = new FlxPoint(Math.cos(drad) * power, Math.sin(drad) * power);
			var a:FlxPoint = new FlxPoint(0, 1);
			//FlxG.log("START");
			var c:FlxPoint = new FlxPoint(point.x, point.y);
			drawShape.graphics.beginFill(0xFF99FF);
			drawShape.graphics.moveTo(point.x, point.y);
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

		override public function update():void
		{
			direction += 1;
			super.update();
		}
    }
}