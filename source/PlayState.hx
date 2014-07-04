package;

import flixel.effects.particles.FlxParticle;
import flixel.effects.particles.FlxEmitter;
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

	private var emitter: FlxEmitter;

	override public function create():Void
	{
		super.create();

		FlxG.camera.bgColor = 0xff276004;

		Context.gameState = Context.IN_PROGRESS;

		createBat();
		createWalls();
		createBall();
		createBricks();
		createEmitter();
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
		ball.maxVelocity.set(200, 200);
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

	private function createEmitter(): Void
	{
		emitter = new FlxEmitter(0, 0);
		emitter.maxSize = 10;
		add(emitter);

		for (i in 0...10)
		{
			var particle = new FlxParticle();
			particle.makeGraphic(5, 5, 0xffffffff);
			particle.visible = false;
			particle.useFading = true;
			emitter.add(particle);
		}
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		if (Context.gameState == Context.IN_PROGRESS)
		{
			super.update();

			moveBat();
			checkCollisions();
			checkHell();
			checkHeaven();
		}

        if (FlxG.keys.justPressed.ESCAPE)
        {
            FlxG.switchState(new MenuState());
        }
        else if (FlxG.keys.justPressed.H)
        {
            var alive = bricks.countLiving();
            var killed = 0;
            while (killed < alive / 2)
            {
                bricks.getFirstAlive().kill();
                killed++;
            }
        }
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

		#if touch_support
			moveBat_touch();
		#end

		if (bat.x < 0)
		{
			bat.x = 0;
		}
		else if (bat.x > 540)
		{
			bat.x = 540;
		}
	}

	private function moveBat_touch(): Void {
		if (FlxG.mouse.pressed) {
			var futureX = FlxG.mouse.screenX - FlxG.worldBounds.left;
			var currentX = bat.x + bat.width / 2 - FlxG.worldBounds.left;

			var gap = gap(currentX, futureX);

			if (gap > 0 && bat.x < 520) {
				bat.velocity.x = 500;
			} else if (gap < 0 && bat.x > 20) {
				bat.velocity.x = -500;
			} else {
				bat.velocity.x = 0;
			}
		} else {
			bat.velocity.x = 0;
		}
	}

	private function gap(xFrom: Float, xTo: Float): Float
	{
		var gap = xTo - xFrom;
		if (Math.abs(gap) > 2) {
			return gap;
		} else return 0;
	}

	private function checkCollisions(): Void
	{
		FlxG.collide(ball, walls, beatWall);
		FlxG.collide(ball, bat, beatHappens);
		FlxG.collide(ball, bricks, beatBrick);
	}

	private function checkHell(): Void
	{
		if (ball.y > 520)
		{
			Context.gameState = Context.GAME_OVER;
			FlxG.camera.fade(0xff000000, 1, false, gotoHellOrHeaven, true);
            FlxG.sound.playMusic("assets/fail.wav", 1, false);
		}
	}

	private function checkHeaven(): Void
	{
		if (bricks.countLiving() <= 0)
		{
			Context.gameState = Context.WINNER;
			FlxG.camera.fade(0xffffffff, 1, false, gotoHellOrHeaven, true);
            FlxG.sound.playMusic("assets/win.wav", 1, false);
		}
	}

    private function beatWall(ball: FlxObject, wall: FlxObject): Void
    {
        FlxG.sound.play("assets/bat.wav");
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

        FlxG.sound.play("assets/bat.wav");
	}

	private function beatBrick(ball: FlxObject, brick: FlxObject): Void
	{
		brick.kill();

		emitter.x = brick.x + brick.width / 2;
		emitter.y = brick.y + brick.height / 2;
		emitter.start(true, 2);

        FlxG.sound.play("assets/brick.wav");
	}

	private function gotoHellOrHeaven(): Void
	{
		FlxG.switchState(new InfoState());
	}
}