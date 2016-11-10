package;

import flixel.text.FlxText;
import flixel.FlxG;
using StringTools;

class Countdown extends FlxText {
    var time:Float = 300;
    public var minsLeft(get,never):Int;
    public var secsLeft(get,never):Int;
    public static var done:Bool = false;
    public static var stopped:Bool = true;

    public function start() {
        stopped = false;
        visible = true;
    }

    public function new() {
        super(0,850,420,"");
        setFormat("assets/fonts/PIXELADE.TTF");
        size = 64;
        alignment = RIGHT;
        color = 0xff000000;
        setBorderStyle(OUTLINE,0xffffffff,4);
        visible = false;
    }

    override public function update(d) {
        super.update(d);
        if(!done && !stopped) {
            time -= d;
            var secs = Std.string(secsLeft).lpad("0",2);
            if(time < 0) done = true;
            else text = '$minsLeft:$secs';

        }
    }

    public function get_minsLeft() {
        return Std.int(Math.floor(time) /60);
    }

    public function get_secsLeft() {
        return Std.int(Math.floor(time) % 60);
    }

    public function stop() {
        stopped = true;
        color = 0xff777777;
    }

}
