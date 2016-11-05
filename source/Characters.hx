package;

import flixel.FlxG;
using Objects;
using Rooms;

class Character extends SmallObject {

    var walkSpeed:Float = 2.5;
    var walk:Null<{pos:Float,then:Void->Void}> = null;
    var speeches:Array<Speech>=[];

    public function new(x:Int,y:Int):Void {
        super(x,y);
        say("hi");
        say("hi2");
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

        updateHitbox();
        offset.x +=((x-currentRoom.x) % Game.SCALE_FACTOR);

        for(i in 0...speeches.length) {
            var s = speeches[i];
            s.x = x+width/2;
            s.y = y-(speeches.length-i)*Speech.SIZE;
            s.updateHitbox();
            s.offset.x = s.width/2;//+ (s.x % Game.SCALE_FACTOR);
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

    public function say(s:String) {
        speeches.push(cast FlxG.state.add(new Speech(s,speeches)));
    }

}

class Player extends Character {

    public function new(x,y):Void {


        super(x, y);

        loadGraphic("assets/images/player.png", true, 14,18);
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
                //x -= 5;
                moving = true;
                facing = flixel.FlxObject.RIGHT;
                flipX = true;
            }
            else if (_right){
                //x += 5;
                moving = true;
                facing = flixel.FlxObject.LEFT;
                flipX = false;
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
