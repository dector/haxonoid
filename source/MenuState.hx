package;

import widgets.TwoStateText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

class MenuState extends FlxState
{
	private var menuValue1: TwoStateText;
	private var menuValue2: TwoStateText;

	override public function create():Void
	{
		super.create();

		FlxG.camera.bgColor = 0xff222222;

		menuValue1 = new TwoStateText(20, 200, 600, "Start Game", 15);
		menuValue1.antialiasing = true;
		menuValue1.alignment = "center";

		menuValue2 = new TwoStateText(20, 240, 600, "Show me cat!", 15);
		menuValue2.antialiasing = true;
		menuValue2.alignment = "center";

		add(menuValue1);
		add(menuValue2);

		menuValue1.selected = true;
	}
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		super.update();

		if (FlxG.keys.justPressed.UP)
		{
			if (menuValue1.selected)
			{
				menuValue1.selected = false;
				menuValue2.selected = true;
			}
			else if (menuValue2.selected)
			{
				menuValue1.selected = true;
				menuValue2.selected = false;
			}
		}
		else if (FlxG.keys.justPressed.DOWN)
		{
			if (menuValue1.selected)
			{
				menuValue1.selected = false;
				menuValue2.selected = true;
			}
			else if (menuValue2.selected)
			{
				menuValue1.selected = true;
				menuValue2.selected = false;
			}
		}

		if (FlxG.keys.justPressed.ENTER)
		{
			if (menuValue1.selected)
			{
				FlxG.switchState(new PlayState());
			}
			else if (menuValue2.selected)
			{
				FlxG.switchState(new AboutState());
			}
		}
	}	
}
