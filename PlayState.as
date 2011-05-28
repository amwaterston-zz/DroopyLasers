/*mxmlc HelloWorld.as -compiler.include-libraries ./OSCConnector-0_6_1.swc -static-link-runtime-shared-libraries=true*/
package
{
	import org.flixel.*;
	import it.h_umus.osc.*
	
	public class PlayState extends FlxState
	{
		public var level:FlxTilemap;
		public var player:FlxSprite;
		public var osc:OSCConnection;
		
		public var amp1:Number;
		public var pitch1:Number;
		public var amp2:Number;
		public var pitch2:Number;
		public var laser1:LaserCurve;
		public var laser2:LaserCurve;
		public var bucket1:Bucket;
		public var bucket2:Bucket;
		
		protected const _bloom:uint = 6;	//How much light bloom to have - larger numbers = more
		protected var _fx:FlxSprite;		//Our helper sprite - basically a mini screen buffer (see below)
		
		[Embed(source="assets/droopyLaser_blue.png")] private var ImgBlueChar:Class;
		[Embed(source="assets/droopyLaser_red.png")] private var ImgRedChar:Class;
		
		[Embed(source="assets/gameloop.mp3")] private var SndGameLoop:Class;
		[Embed(source="assets/menu.mp3")] private var SndMenu:Class;
		[Embed(source="assets/laser_bucket.mp3")] private var SndBucket:Class;
		[Embed(source="assets/nearly_full.mp3")] private var SndNearFull:Class;
		[Embed(source="assets/win.mp3")] private var SndWin:Class;

		override public function create():void
		{
			FlxG.playMusic(SndGameLoop);
			
			osc = new OSCConnection("127.0.0.1", 9001);
			osc.addEventListener(OSCConnectionEvent.OSC_PACKET_IN, oscIn);
			osc.connect("127.0.0.1", 9001);
			amp1 = amp2 = pitch1 = pitch2 = 0;
			
			FlxG.bgColor = 0xff000000;
			
				
				player = new FlxSprite(FlxG.width/2 - 5);
				player.makeGraphic(10, 12, 0xffaa1111);
				player.maxVelocity.x = 80;
				player.maxVelocity.y = 200;
				player.acceleration.y = 200;
				player.drag.x = player.maxVelocity.x * 4;
				//add(player);
				
				laser1 = new LaserCurve(new FlxPoint(80, 376), 0x02b2ff, ImgBlueChar);
				add(laser1);
				
				bucket1 = new Bucket(FlxG.width/3, 320);
				add(bucket1);
				bucket2 = new Bucket(FlxG.width * 2/3, 320);
				add(bucket2);
				laser2 = new LaserCurve(new FlxPoint(620, 320), 0xff0258, ImgRedChar, true);
				add(laser2);
				laser2.direction = 180;
				
				FlxG.watch(this, "pitch1");
				FlxG.watch(laser1, "direction");
				FlxG.watch(laser1, "currentDirection");
				
				FlxG.watch(this, "amp1");
				FlxG.watch(laser1, "power");
				FlxG.watch(laser1, "currentPower");

				FlxG.watch(laser2, "currentDirection");
				
				_fx = new FlxSprite();
				_fx.makeGraphic(FlxG.width/_bloom,FlxG.height/_bloom,0,true);
				_fx.setOriginToCorner();	//Zero out the origin so scaling goes from top-left, not from center
				_fx.scale.x = _bloom;		//Scale it up to be the same size as the screen again
				_fx.scale.y = _bloom;		//Scale it up to be the same size as the screen again
				_fx.antialiasing = true;	//Set AA to true for maximum blurry
				_fx.blend = "screen";		//Set blend mode to "screen" to make the blurred copy transparent and brightening
				
				FlxG.camera.screen.scale.x = 1/_bloom;
				FlxG.camera.screen.scale.y = 1/_bloom;
				
		}
		
		override public function update():void
		{
			/*laser1.power = 10; //amp1 * 10 + 1;
			if (amp1 > 0.1)
			{
				laser1.direction = pitch1 * 90 + 45;
			}*/
			
			if (FlxG.keys.LEFT)
				laser1.direction += 1;
			if (FlxG.keys.RIGHT)
				laser1.direction -= 1;
			if (FlxG.keys.UP)
				laser1.power += 1;
			if (FlxG.keys.DOWN)
				laser1.power -= 1;
			
			if (FlxG.keys.A)
				laser2.direction += 1;
			if (FlxG.keys.D)
				laser2.direction -= 1;
			if (FlxG.keys.W)
				laser2.power += 1;
			if (FlxG.keys.S)
				laser2.power -= 1;
				
			if (laser1.passesThrough(bucket1.origin))
				FlxG.log("Whoop");
				
			super.update();
		}
		override public function draw():void
		{
			super.draw();
			_fx.stamp(FlxG.camera.screen);
			_fx.draw();
			
		}
		public function oscIn(e:OSCConnectionEvent):void
		{
			for (var i:int = 0; i < e.data.messages.length; i++)
			{
				var message = e.data.messages[i];
				FlxG.log(message.name);
				if(message.name == "/amp"){
					if(message.getArgumentValue(0) == 1){
						amp1 = message.getArgumentValue(1) as Number;
					}else{
						amp2 = message.getArgumentValue(1) as Number;
					}
				}
				if(message.name == "/pitch"){
					if(message.getArgumentValue(0) == 1){
						pitch1 = message.getArgumentValue(1) as Number;
					}else{
						pitch2 = message.getArgumentValue(1) as Number;
					}
				}
			}
		}
		private function onConnect(evtEvent:OSCConnectionEvent):void {
			FlxG.log("connect");
		}

		private function onConnectError(evtEvent:OSCConnectionEvent):void {
			FlxG.log("errord");
		}

		private function onClose(evtEvent:OSCConnectionEvent):void {
			FlxG.log("connection closed");
		}
		
	}
}