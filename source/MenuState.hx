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
	private static inline var MENU_START = "Start Game";
	private static inline var MENU_CATS = "Show me cat!";

	private var menuValue1: TwoStateText;
	private var menuValue2: TwoStateText;

	override public function create():Void
	{
		super.create();

		FlxG.camera.bgColor = 0xff29745c;

		menuValue1 = new TwoStateText(20, 200, 600, "> " + MENU_START + " <", 25);
		menuValue1.antialiasing = true;
		menuValue1.alignment = "center";

		menuValue2 = new TwoStateText(20, 240, 600, MENU_CATS, 25);
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

		if (FlxG.keys.justPressed.UP || FlxG.keys.justPressed.DOWN)
		{
			if (menuValue1.selected)
			{
				select(1);
			}
			else if (menuValue2.selected)
			{
				select(0);
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

		#if touch_support
			if (FlxG.mouse.justPressed) {
				var x = FlxG.mouse.screenX;
				var y = FlxG.mouse.screenY;

				if (menuValue1.x <= x && x <= menuValue1.x + menuValue1.width
					&& menuValue1.y <= y && y <= menuValue1.y + menuValue1.height) {
					FlxG.switchState(new PlayState());
				} else if (menuValue2.x <= x && x <= menuValue2.x + menuValue2.width
					&& menuValue2.y <= y && y <= menuValue2.y + menuValue2.height) {
					FlxG.switchState(new AboutState());
				}
			}
		#end
	}

	private function select(position: Int)
	{
		switch (position)
		{
			case 0:
				menuValue1.selected = true;
				menuValue2.selected = false;
				menuValue1.text = "> " + MENU_START + " <";
				menuValue2.text = MENU_CATS;
			case 1:
				menuValue1.selected = false;
				menuValue2.selected = true;
				menuValue1.text = MENU_START;
				menuValue2.text = "> " + MENU_CATS + " <";
		}
	}
}
