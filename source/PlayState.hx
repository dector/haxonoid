package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

class PlayState extends FlxState
{
	private var bat: FlxSprite;

	override public function create():Void
	{
		super.create();

		createBat();
	}

	private function createBat(): Void
	{
		bat = new FlxSprite(270, 420);
		bat.makeGraphic(100, 20, 0xffffffff);
		add(bat);
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();
	}	
}