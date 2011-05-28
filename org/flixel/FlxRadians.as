package org.flixel
{
   public class FlxRadians {
      public var value:Number=0;
      public function FlxRadians( input:Number=0 ) { value = input; }
      public function to_degrees():FlxDegrees {
         return new FlxDegrees( (value*180)/Math.PI );
      }
   }
}