package;

import flixel.text.FlxText;
import flixel.FlxG;

class Countdown extends FlxText {
    var time:Float = 300;
    public var minsLeft(get,never):Int;
    public var secsLeft(get,never):Int;

    public function new() {
        super(0,920,FlxG.width,"");
        setFormat("assets/fonts/PIXELADE.TTF");
        size = 64;
        color = 0xff000000;
        setBorderStyle(OUTLINE,0xffffffff,4);
    }

    override public function update(d) {
        super.update(d);
        time -= d;

        text = '$minsLeft:$secsLeft';
    }

    public function get_minsLeft() {
        return Std.int(Math.ceil(time) /60);
    }

    public function get_secsLeft() {
        return Std.int(Math.ceil(time) % 60);
    }

}
