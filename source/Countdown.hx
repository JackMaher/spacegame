package;

import flixel.text.FlxText;
import flixel.FlxG;
using StringTools;

class Countdown extends FlxText {
    var time:Float = 300;
    public var minsLeft(get,never):Int;
    public var secsLeft(get,never):Int;
    public static var done:Bool = false;
    public static var stopped:Bool = false;

    public function new() {
        super(0,920,420,"");
        setFormat("assets/fonts/PIXELADE.TTF");
        size = 64;
        alignment = RIGHT;
        color = 0xff000000;
        setBorderStyle(OUTLINE,0xffffffff,4);
    }

    override public function update(d) {
        super.update(d);
        if(!done && !stopped) {
            time -= d;
            if(time < 0) done = true;
            var secs = secsLeft.lpad(2,"0");
            else text = '$minsLeft:$secs';
        }
    }

    public function get_minsLeft() {
        return Std.int(Math.ceil(time) /60);
    }

    public function get_secsLeft() {
        return Std.int(Math.ceil(time) % 60);
    }

    public function stop() {
        stopped = true;
        color = 0xff777777;
    }

}
