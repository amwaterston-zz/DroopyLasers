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
		public var currentPower:Number;
		public var currentDirection:Number;

        function LaserCurve(location:FlxPoint) 
		{
			this.location = location;
			this.direction = 0;
			this.currentDirection = 0;
			this.power = 10;
			this.currentPower = 0;
        }
		
        override public function draw():void 
		{
			if (power == 0)
				return;
				
            drawShape = new Shape();
			drawShape.graphics.lineStyle(1, 0xFFD700);

			var drad = (currentDirection / 360) * 2 * 3.1415926535;
			var gravity = +9.8;
			var v:FlxPoint = new FlxPoint(Math.cos(drad) * currentPower, Math.sin(drad) * currentPower);
			var a:FlxPoint = new FlxPoint(0, 1);
			//FlxG.log("START");
			var c:FlxPoint = new FlxPoint(location.x, location.y);
			//drawShape.graphics.beginFill(0xFF99FF);
			drawShape.graphics.moveTo(location.x, location.y);
			for (var i:int = 0; i < 10; i++)
			{
				v.x += a.x;
				v.y += a.y;
				c.x += v.x;
				c.y += v.y;
				//FlxG.log(c.x + ", " + c.y);
	            drawShape.graphics.lineTo(c.x, c.y);
			}
			FlxG.camera.buffer.draw(drawShape);		
        }

		public function passesNear(point:FlxPoint):Boolean
		{
			var drad = (currentDirection / 360) * 2 * 3.1415926535;
			var gravity = +9.8;
			var v:FlxPoint = new FlxPoint(Math.cos(drad) * currentPower, Math.sin(drad) * currentPower);
			var a:FlxPoint = new FlxPoint(0, 1);
			var c:FlxPoint = new FlxPoint(location.x, location.y);
			var oldc:FlxPoint = new FlxPoint(location.x, location.y);
			var closest:Number = 10000000;
			
			var bline:FlxLine = new FlxLine(point, new FlxPoint(point.x, point.y - 200));
			
			for (var i:int = 0; i < 10; i++)
			{
				v.x += a.x;
				v.y += a.y;
				c.x += v.x;
				c.y += v.y;
				
				var d:Number = Math.sqrt( Math.pow(c.x - point.x, 2) + Math.pow(c.y - point.y, 2));
				FlxG.log("d: " + d + ", i: " + i)
				if (d < 10)
				{
					return true;
				}
			}
			return false;
		}
		
		override public function update():void
		{	
			if (Math.abs(currentPower - power) < 1.5)
				currentPower = power;
			else if (currentPower < power)
				currentPower += 1;
			else if (currentPower > power)
				currentPower -= 0.1;
				
			if (Math.abs(currentDirection - direction) < 7)
				currentDirection = direction;
			else if (currentDirection < direction)
				currentDirection += 5;
			else if (currentDirection > direction)
				currentDirection -= 5;
				
			super.update();
		}
    }
}