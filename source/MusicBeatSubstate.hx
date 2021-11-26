package;

import flixel.FlxG;
import flixel.FlxSubState;
#if mobileC
import ui.FlxVirtualPad;
import flixel.input.actions.FlxActionInput;
#end

class MusicBeatSubstate extends FlxSubState
{
	public function new()
	{
		super();
	}

	private var lastBeat:Float = 0;
	private var lastStep:Float = 0;

	private var totalBeats:Int = 0;
	private var totalSteps:Int = 0;

	private var curStep:Int = 0;
	private var curBeat:Int = 0;
	private var controls(get, never):Controls;

	inline function get_controls():Controls
		return PlayerSettings.player1.controls;

	#if mobileC
	var _virtualpad:FlxVirtualPad;

	var trackedinputs:Array<FlxActionInput> = [];

	// adding virtualpad to state
	public function addVirtualPad(?DPad:FlxDPadMode, ?Action:FlxActionMode) {
		_virtualpad = new FlxVirtualPad(DPad, Action);
		_virtualpad.alpha = 0.75;
		add(_virtualpad);
		controls.setVirtualPad(_virtualpad, DPad, Action);
		trackedinputs = controls.trackedinputs;
		controls.trackedinputs = [];
	}
	
	override function destroy() {
		controls.removeFlxInput(trackedinputs);

		super.destroy();
	}
	#else
	public function addVirtualPad(?DPad, ?Action){};
	#end		

	override function create()
	{
		super.create();
	}

	override function update(elapsed:Float)
	{
		everyStep();

		updateCurStep();
		curBeat = Math.round(curStep / 4);

		super.update(elapsed);
	}

	/**
	 * CHECKS EVERY FRAME
	 */
	private function everyStep():Void
	{
		if (Conductor.songPosition > lastStep + Conductor.stepCrochet - Conductor.safeZoneOffset
			|| Conductor.songPosition < lastStep + Conductor.safeZoneOffset)
		{
			if (Conductor.songPosition > lastStep + Conductor.stepCrochet)
			{
				stepHit();
			}
		}
	}

	private function updateCurStep():Void
	{
		curStep = Math.floor(Conductor.songPosition / Conductor.stepCrochet);
	}

	public function stepHit():Void
	{
		totalSteps += 1;
		lastStep += Conductor.stepCrochet;

		if (totalSteps % 4 == 0)
			beatHit();
	}

	public function beatHit():Void
	{
		lastBeat += Conductor.crochet;
		totalBeats += 1;
	}
}
