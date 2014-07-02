package;

import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

class PlayState extends FlxState
{
	private var bat: FlxSprite;
	private var walls: FlxGroup;

	override public function create():Void
	{
		super.create();

		createBat();
		createWalls();
	}

	private function createBat(): Void
	{
		bat = new FlxSprite(270, 420);
		bat.makeGraphic(100, 20, 0xffffffff);
		add(bat);
	}

	private function createWalls(): Void
	{
		walls = new FlxGroup();
		add(walls);

		var left = new FlxSprite(0, 0);
		left.makeGraphic(20, 480, 0xff999999);
		walls.add(left);

		var right = new FlxSprite(620, 0);
		right.makeGraphic(20, 480, 0xff999999);
		walls.add(right);

		var top = new FlxSprite(0, 0);
		top.makeGraphic(640, 20, 0xff999999);
		walls.add(top);
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
		if (FlxG.keys.pressed.LEFT && bat.x > 20)
		{
			bat.velocity.x = -500;
		}
		else if (FlxG.keys.pressed.RIGHT && bat.x < 520)
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