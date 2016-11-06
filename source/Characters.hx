package;

import flixel.FlxG;
using Definitions;

class Player extends Character {

    public function new(x,y):Void {

        super(x, y);

        loadGraphic("assets/images/player.png", true, 14,18);
        animation.add("lr", [0,1,2], 6, false);
        animation.add("idle", [3,4], 3,false);
    }

    private function movement():Void {

        var _left  = false;
        var _right = false;

        if(walk != null) {
            if(x > walk.pos) _left = true;
            if(x < walk.pos) _right = true;
        }
        else {
            if(flixel.FlxG.keys.anyPressed(["LEFT","A"])) _left = true;
            if(flixel.FlxG.keys.anyPressed(["RIGHT","D"])) _right = true;
        }

        var moving:Bool = _left || _right;

        if (_left && _right)
            _left = _right = false;


        if (_left){
            if(walk==null) x -= 5;
            flipX = true;
        }
        else if (_right){
            if(walk==null) x += 5;
            flipX = false;
        }

        if (moving){
            /*_sndStep.play();*/
            animation.play("lr");
        }
        else {
            animation.play("idle");
        }
    }

    override public function update (d){
        super.update(d);
        movement();
    }
}


class Sodsbury extends Character {
    public function new(x,y):Void {
        super (x,y);
        loadGraphic ("assets/images/sodsbury.png", true, 5,13);
        animation.add("walk", [0,1,2,3], 4, true);
        animation.play("walk");
    }

    public function look(){

    }
}
