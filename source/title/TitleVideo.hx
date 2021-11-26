package title;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxGroup;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.util.FlxColor;

using StringTools;

class TitleVideo extends FlxState
{

	var blackScreen:FlxSprite;
	var credGroup:FlxGroup;
	var textGroup:FlxGroup;
	var ngSpr:FlxSprite;

	var curWacky:Array<String> = [];

	var wackyImage:FlxSprite;

	override public function create():Void
	{

		super.create();

		if(!Main.novid)
		{
			FlxG.switchState(new VideoState('assets/videos/klaskiiTitle.webm', function(){

				FlxG.camera.flash(FlxColor.WHITE, 60);
				FlxG.sound.playMusic(Paths.music("klaskiiLoop"), 0.75);
				Conductor.changeBPM(158);
			        FlxG.switchState(new TitleScreen());
			}));
		}
		else
		{
			FlxG.camera.flash(FlxColor.WHITE, 60);
			FlxG.sound.playMusic(Paths.music("klaskiiLoop"), 0.75);
			Conductor.changeBPM(158);
			FlxG.switchState(new TitleScreen());
		}
	}

	override public function update(elapsed:Float)
	{

		super.update(elapsed);

	}
	
}
