package;
using Objects;
using StringTools;
using Characters;
using Lambda;
using Reflect;
using Type;
import flixel.FlxG;

class Room extends Object {

    public var objects:Array<Object> = [];

    public function new() {
        super(0,0);
    }

    public function create() {}

    public function getX(X) {
        return FlxG.width/2 - width/2
            + X * Game.SCALE_FACTOR;
    }
    public function getY(Y) {
        return Game.ROOM_HEIGHT/2 - height/2
            + Y * Game.SCALE_FACTOR;
    }

    public function v_leave() {
        for(o in objects) {
            FlxG.state.remove(o);
        }
        if(field("leave") != null)
            callMethod(field("leave"), []);

    }

    public function v_enter() {
        for(o in objects) {
            FlxG.state.add(o);
        }
        if(field("enter") != null)
            callMethod(field("enter"), []);
    }

    override function roomPos(X:Float,y:Float) {
        return {x:FlxG.width/2-width/2,
            y:Game.ROOM_HEIGHT/2-height/2+Game.ROOM_TOP};
    }

    public function get(O:String):Object {
        var k = objects.find(function(o){return o.n==O;});
        if(k == null) throw ("no object "+O+" in room!");
        trace(k.n + ", " + k.x);
        return k;
    }

    public function getCharacter(O:String):Character {
        var k = objects.find(function(o){return o.n==O;});
        if(k == null) throw ("no object "+O+" in room!");
        trace(k.n + ", " + k.x);
        return cast(k,Character);
    }

}

class Hallway1 extends Room {

    public function new() {
        super();
    }

    override public function create() {
        objects = [new Sodsbury(0,0),
                   new Player(20,0),
                   new SmallObject(40,0)];
    }
    function enter() {
        getCharacter("sodsbury").walkToObject("player");
    }

}

class Cargo extends Room{
    public function new(){
        super();
    }
    override public function create (){
        objects = [new Player(30,32),
                    new Crewmember(4,34),];
    }

}
