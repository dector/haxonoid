package;

import flixel.FlxObject;
import flixel.FlxObject;
import flixel.util.FlxRandom;
import flixel.util.FlxRandom;
import flixel.group.FlxGroup;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

class PlayState extends FlxState
{
	private static var BRICK_COLOR(default, null) = [ 0xffa03951, 0xffae643e, 0xff29745c, 0xff5b9836 ];

	private var bat: FlxSprite;
	private var walls: FlxGroup;
	private var ball: FlxSprite;
	private var bricks: FlxGroup;

	override public function create():Void
	{
		super.create();

		FlxG.camera.bgColor = 0xff276004;

		createBat();
		createWalls();
		createBall();
		createBricks();
	}

	private function createBat(): Void
	{
		bat = new FlxSprite(270, 420);
		bat.makeGraphic(100, 20, 0xff034932);
		bat.immovable = true;
		add(bat);
	}

	private function createWalls(): Void
	{
		walls = new FlxGroup();
		add(walls);

		var left = new FlxSprite(0, 0);
		left.makeGraphic(20, 480, 0xff034932);
		left.immovable = true;
		walls.add(left);

		var right = new FlxSprite(620, 0);
		right.makeGraphic(20, 480, 0xff034932);
		right.immovable = true;
		walls.add(right);

		var top = new FlxSprite(0, 0);
		top.makeGraphic(640, 20, 0xff034932);
		top.immovable = true;
		walls.add(top);
	}

	private function createBall(): Void
	{
		ball = new FlxSprite(310, 320);
		ball.makeGraphic(20, 20, 0xffce8b69);
		ball.elasticity = 1;
		ball.maxVelocity.set(300, 300);
		ball.velocity.y = 300;
		add(ball);
	}

	private function createBricks(): Void
	{
		bricks = new FlxGroup();
		add(bricks);

		for (i in 0...7)
		{
			for (j in 0...4)
			{
				var brick = new FlxSprite(i * (60 + 5) + 30 + 65, j * (40 + 5) + 30 + 45);
				var color = BRICK_COLOR[FlxRandom.intRanged(0, BRICK_COLOR.length - 1)];
				brick.makeGraphic(60, 40, color);
				brick.immovable = true;
				bricks.add(brick);
			}
		}
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();

		moveBat();
		checkCollisions();
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

	private function checkCollisions(): Void
	{
		FlxG.collide(ball, walls);
		FlxG.collide(ball, bat, beatHappens);
		FlxG.collide(ball, bricks, beatBrick);
	}

	private function beatHappens(ball: FlxObject, bat: FlxObject): Void
	{
		var batmid = bat.x + bat.width / 2;
		var ballmid = ball.x + ball.width / 2;
		var diff;

		if (batmid != ballmid)
		{
			ball.velocity.x = 10 * (ballmid - batmid);
		}
		else
		{
			var diff = cast(bat.width / 4 - ball.width / 4, Int);
			ball.velocity.x = 10 * FlxRandom.intRanged(-diff, diff);
		}
	}

	private function beatBrick(ball: FlxObject, brick: FlxObject): Void
	{
		brick.kill();
	}
}