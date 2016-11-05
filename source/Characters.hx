package;

using Objects;
using Rooms;

class Character extends SmallObject {

    var walkSpeed:Float = 5;
    var walk:Null<{pos:Float,then:Void->Void}> = null;

    public function new(x,y):Void {
        super(x,y);
    }

    override public function update(d):Void {

        if(walk != null) {
            if(Math.abs(walk.pos-x) < walkSpeed) {
                x = walk.pos;
                if(walk.then != null) walk.then();
                walk = null;
            }
            else x += walkSpeed * (walk.pos-x>0?1:-1);
        }
        super.update(d);

    }

    public function walkToObject(ne:String, ?then:Void->Void):Void {
        walkTo(currentRoom.get(ne).x, then);
    }

    public function walkTo(pos:Float, ?then:Void->Void):Void {
        trace("walking to " + pos);
        walk = {pos:pos, then:then};
    }

}

class Player extends Character {

    public function new(x,y):Void {


        super(x, y);

        loadGraphic("assets/images/player.png", true, 13,18);
        animation.add("lr", [0,1,2], 6, false);
        animation.add("idle", [4,5], 3,false);
    }

    private function movement():Void{
        var _left:Bool = false;
        var _right:Bool = false;

        _left = flixel.FlxG.keys.anyPressed(["LEFT","A"]);
        _right = flixel.FlxG.keys.anyPressed(["RIGHT","D"]);

        var moving:Bool = false;

        if (_left && _right)
            _left = _right = false;

        if (_left || _right){

            if (_left){
                x -= 5;
                moving = true;
                facing = flixel.FlxObject.RIGHT;
            }
            else if (_right){
                x += 5;
                moving = true;
                facing = flixel.FlxObject.LEFT;
            }

                if ((moving) && touching == flixel.FlxObject.NONE){
                /*_sndStep.play();*/
                switch(facing){
                    case flixel.FlxObject.LEFT, flixel.FlxObject.RIGHT:
                        animation.play("lr");

                    }

                }
            }
        }
    override public function update (d){
        super.update(d);
        movement();
    }
}


class Sodsbury extends Character {

}
