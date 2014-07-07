package states;

import flixel.util.FlxColor;
import common.Strings;
import widgets.LinearLayout;
import widgets.LinearLayout;
import widgets.TwoStateText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

class MenuState extends FlxState
{
	private var layout: LinearLayout;

	override public function create():Void
	{
		super.create();

		bgColor = 0xff29745c;

        layout = new LinearLayout(0, 0, FlxG.width, FlxG.height);
        add(layout);

        layout.add(createButton(0, 0, 2, Strings.MENU_START_GAME, function () {
            FlxG.switchState(new PlayState());
        }));
        layout.add(createButton(0, 0, 2, Strings.MENU_NOTHING));
        layout.spacing = 20;
        layout.layout();
	}

    private function createButton(x: Int = 0, y: Int = 0, scale: Int = 1, ?title: String, ?callback: Void->Void): FlxButton {
        var button = new FlxButton(0, 0, callback);
        button.text = title;
        button.scale.set(scale, scale);
        button.updateHitbox();
        button.label.fieldWidth *= scale;
        button.labelOffsets[FlxButton.NORMAL].x *= scale;
        button.labelOffsets[FlxButton.NORMAL].y *= scale;
        button.labelOffsets[FlxButton.HIGHLIGHT].x *= scale;
        button.labelOffsets[FlxButton.HIGHLIGHT].y *= scale;
        button.labelOffsets[FlxButton.PRESSED].x *= scale;
        button.labelOffsets[FlxButton.PRESSED].y *= scale;
        button.label.size *= scale;

        return button;
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
