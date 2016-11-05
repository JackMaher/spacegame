package;

using Objects;
using Rooms;

class Character extends SmallObject {

    var walkSpeed:Float = 2.5;
    var walk:Null<{pos:Float,then:Void->Void}> = null;

    public function new(x:Int,y:Int):Void {
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

        updateHitbox();
        offset.x +=(x % Game.SCALE_FACTOR);

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
        super(x,y);
    }

}

class Sodsbury extends Character {

}
