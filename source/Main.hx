package;

import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{

	public static var fpsDisplay:FPS;

	public static var novid:Bool = false;
	public static var flippymode:Bool = false;

	public function new()
	{
		super();

		#if sys
		novid = Sys.args().contains("-novid");
		flippymode = Sys.args().contains("-flippymode");
		#end

		addChild(new FlxGame(1280, 720, Startup, 1, 60, 60, true));

		fpsDisplay = new FPS(10, 3, 0xFFFFFF);
		fpsDisplay.visible = false;
		addChild(fpsDisplay);

		if(!novid){
			var ourSource:String = "assets/videos/DO NOT DELETE OR GAME WILL CRASH/dontDelete.webm";

			#if web
			var str1:String = "HTML CRAP";
			var vHandler = new VideoHandler();
			vHandler.init1();
			vHandler.video.name = str1;
			addChild(vHandler.video);
			vHandler.init2();
			GlobalVideo.setVid(vHandler);
			vHandler.source(ourSource);
			#elseif sys
			var str1:String = "WEBM SHIT"; 
			var webmHandle = new WebmHandler();
			webmHandle.source(ourSource);
			webmHandle.makePlayer();
			webmHandle.webm.name = str1;
			addChild(webmHandle.webm);
			GlobalVideo.setWebm(webmHandle);
			#end
		}

		trace("-=Args=-");
		trace("novid: " + novid);
		trace("flippymode: " + flippymode);

	}
}
