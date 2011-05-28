package
{
	import org.flixel.*;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.display.Shape;
	
	public class Line extends FlxSprite
	{
		protected var drawShape:Shape;
		protected var point1:FlxPoint;
		protected var point2:FlxPoint;

        function Line(point1:FlxPoint, point2:FlxPoint) 
		{
			this.point1 = point1;
			this.point2 = point2;
        }

        override public function draw():void 
		{
            drawShape = new Shape();
            drawShape.graphics.lineStyle(1, 0x999999);
            drawShape.graphics.moveTo(point1.x, point1.y);
            drawShape.graphics.curveTo(0, 50, point2.x, point2.y);
            FlxG.camera.buffer.draw(drawShape);
        }
    }
}