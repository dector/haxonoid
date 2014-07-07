package widgets;

import flixel.util.FlxMath;
import tools.Log;
import flixel.FlxSprite;
import flixel.util.FlxRandom;
import flixel.FlxObject;
import flixel.group.FlxGroup;

class LinearLayout extends FlxGroup {

    public static inline var ORIENTATION_VERTICAL = 1;
    public static inline var ORIENTATION_HORIZONTAL = 2;

    /*public static inline var GRAVITY_CENTER_VERTICAL = 0x1;
    public static inline var GRAVITY_CENTER_HORIZONTAL = 0x2;
    public static inline var GRAVITY_CENTER = GRAVITY_CENTER_VERTICAL | GRAVITY_CENTER_HORIZONTAL;*/

    public var orientation(default, null) = ORIENTATION_VERTICAL;

    /*public var gravity(default, null) = GRAVITY_CENTER;*/

    public var spacing: Int;

    public var x: Float;
    public var y: Float;
    public var width: Float;
    public var height: Float;

    public function new(x: Float = 0, y: Float = 0, width: Float = 100, height: Float = 100) {
        super();
        this.x = x;
        this.y = y;
        this.width = width;
        this.height = height;
    }

    public function layout() {
        if (orientation == ORIENTATION_VERTICAL) {
            var maxW = 0.;
            var sumH = 0.;

            for (child in members) {
                var childObject = cast(child, FlxSprite);
                sumH += childObject.height;

                maxW = Math.max(maxW, childObject.width);
            }

            sumH += (members.length - 1) * spacing;
            var currentY = (height - sumH) / 2;

            for (child in members) {
                var childObject = cast(child, FlxSprite);

                childObject.x = (width - childObject.width) / 2;
                childObject.y = currentY;

                currentY += childObject.height + spacing;
            }

        }
    }
}
