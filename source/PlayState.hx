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

		moveBat();

	}

	private function moveBat(): Void
	{
		if (FlxG.keys.pressed.LEFT && bat.x > 0)
		{
			bat.velocity.x = -500;
		}
		else if (FlxG.keys.pressed.RIGHT && bat.x < 540)
		{
			bat.velocity.x = 500;
		}
		else
		{
			bat.velocity.x = 0;
		}

		if (bat.x < 0)
		{
			bat.x = 0;
		}
		else if (bat.x > 540)
		{
			bat.x = 540;
		}
	}
}