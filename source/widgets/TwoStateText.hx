package widgets;

import flixel.text.FlxText;

class TwoStateText extends FlxText
{
	private static inline var SELECTED_COLOR: Int = 0xffff0000;
	private static inline var NORMAL_COLOR: Int = 0xffffffff;

	private var _selected: Bool;
	public var selected(get, set): Bool;

	function get_selected(): Bool
	{
		return _selected;
	}

	function set_selected(val: Bool): Bool
	{
		if (val)
		{
			color = SELECTED_COLOR;
		}
		else
		{
			color = NORMAL_COLOR;
		}

		_selected = val;

		return _selected;
	}

	public function new(X:Float = 0, Y:Float = 0, FieldWidth:Float = 0, ?Text:String, Size:Int = 8)
	{
		super(X, Y, FieldWidth, Text, Size);
	}
}
