package states;

import flixel.input.gamepad.XboxButtonID;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxState;

class InfoState extends FlxState
{
	override public function create(): Void
	{
		var mainText = new FlxText(0, 200, 640);
		mainText.size = 30;
		mainText.alignment = "center";

		var secondaryText = new FlxText(0, 250, 640);
		secondaryText.color = 0xffffffff;
		secondaryText.size = 15;
		secondaryText.alignment = "center";

		switch (Context.gameState)
		{
			case Context.GAME_OVER:
				FlxG.camera.bgColor = 0xff000000;

				mainText.color = 0xffdd0000;
				mainText.text = "Game Over!";

				secondaryText.text = "Press <Space> to try again";
			case Context.WINNER:
				FlxG.camera.bgColor = 0xff003300;
				mainText.color = 0xffff00;
				mainText.text = "You are the champion!";

				secondaryText.text = "Press <Space> with pride!";
		}

		add(mainText);
		add(secondaryText);
	}

	public override function update(): Void
	{
		super.update();

        var gamepad = FlxG.gamepads.lastActive;

		if (FlxG.keys.justPressed.SPACE || (Context.TOUCH && FlxG.mouse.justPressed) || gamepad != null && gamepad.justPressed(XboxButtonID.A))
		{
			switch (Context.gameState)
			{
				case Context.GAME_OVER:
                    FlxG.sound.pause();
					FlxG.switchState(new PlayState());
				case Context.WINNER:
                    FlxG.sound.pause();
					FlxG.switchState(new MenuState());
			}
		}
	}
}
