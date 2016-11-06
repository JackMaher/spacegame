package;

import flixel.FlxG;
using Objects;
using Speech;
using Rooms;

class Character extends SmallObject {

    var walkSpeed:Float = 5;
    var walk:Null<{pos:Float,then:Void->Void}> = null;
    public var speeches:Array<Speech>=[];
    public var dialogs:Int = 0;

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
            s.text.visible = true;
            s.x = x+width/2-s.width/2;
            s.y = y-(0.3+speeches.length-i)*Speech.SIZE;
        }

        super.update(d);

    }

    public function walkToObject(ne:String, ?dist:Null<Float> = 0, ?then:Void->Void):Void {
        var ob = currentRoom.get(ne);
        var nx = 0.0;
            if(x < ob.x - dist)
                nx = ob.x - dist;
            else if(x > ob.x + ob.width + dist)
                nx = ob.x + ob.width + dist;
            else
                nx = x;
        walkTo(nx, then);
    }

    public function walkTo(pos:Float, ?then:Void->Void):Void {
        walk = {pos:pos, then:then};
    }

    public function say(s:String) {
        speeches.push(cast FlxG.state.add(new Speech(s,this)));
    }

    public function option(s:String, ?then:Void->Void):Void {
        if(dialogs == 0) {
            for(s in speeches)
                s.kill();
            speeches = [];
        }
        speeches.push(cast FlxG.state.add(new DialogOption(
            s,this,speeches.length+1,then)));
    }
    public function endOptions() {
        dialogs = 0;
    }

}

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
