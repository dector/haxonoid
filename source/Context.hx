package;

class Context
{
	public static inline var IN_PROGRESS = 0;
	public static inline var WINNER = 1;
	public static inline var GAME_OVER = 2;

	public static inline var TOUCH = #if touch_support true #else false #end;

	public static var gameState: Int = -1;
}
