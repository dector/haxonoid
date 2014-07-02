package;

import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;

class AboutState extends FlxState
{
	private var image: FlxSprite;
	private var text: FlxText;

	override public function create()
	{
		image = new FlxSprite(320-64+38, 240-64-40);
		image.loadGraphic("assets/cat.png", true, 64, 64);
		image.animation.add("iddle", [0, 1, 2, 3], 7);
		image.animation.add("walk", [10, 11, 12, 13, 14, 15, 16, 17], 10);
		image.animation.add("kick", [20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30], 7);
		image.animation.play("iddle");
		image.origin.set(32, 32);
		image.scale.set(4, 4);
		add(image);

		text = new FlxText(0, 240+30, 640);
		text.size = 15;
		text.alignment = "center";
		text.text = "iddle";
		add(text);
	}

	override public function update()
	{
		super.update();

		if (FlxG.keys.justPressed.SPACE)
		{
			switch (image.animation.curAnim.name)
			{
				case "iddle":
					image.animation.play("walk");
					text.text = "walk";
				case "walk":
					image.animation.play("kick");
					text.text = "kick";
				case "kick":
					image.animation.play("iddle");
					text.text = "iddle";
			}
		}
		else if (FlxG.keys.justPressed.ESCAPE)
		{
			FlxG.switchState(new MenuState());
		}
	}
}
