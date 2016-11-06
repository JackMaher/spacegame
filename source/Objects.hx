package;
using Objects;
using StringTools;
using Lambda;
using Reflect;
using Rooms;
using Type;
import flixel.FlxSprite;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.math.FlxPoint;

class Key extends SmallObject {
}


/* Generic object definitions */

class SmallObject extends Object {
}

class Object extends FlxSprite {

    public var n(get,never):String;
    public var customName:String="";
    public var currentRoom(get,never):Room;
    var gameX:Int;
    var gameY:Int;


    public function new(X:Int, Y:Int,?asset:String) {
        super();
        gameX = X;
        gameY = Y;
        if(asset == null) loadGraphic('assets/images/$n.png');
        else              loadGraphic('assets/images/$asset.png');
        scale.set(Game.SCALE_FACTOR,Game.SCALE_FACTOR);
        updateHitbox();
        var pos = roomPos(gameX,gameY);
        x = pos.x;
        y = pos.y;

    }

    override public function update(d) {
        super.update(d);
    }

    public function v_look() {
        if(field("look") != null) callMethod(field("look"), []);
    }
    public function v_use() {
        if(field("use") != null) callMethod(field("use"), []);
    }

    /* Helper Functions */

    // Shorthand for name of object.
    public function get_n() {
        if(customName != "") return customName;
        return getClass().getClassName().toLowerCase();
    }

    public function get_currentRoom() {
        return cast(FlxG.state,Game).currentRoom;
    }

    //Work out where this object should be placed.
    function roomPos(X:Float,Y:Float) {
        return {x:currentRoom.x + X*Game.SCALE_FACTOR,
                y:currentRoom.y + Y*Game.SCALE_FACTOR};
    }

    public function isCursorOverPixels():Bool {
        var adjustedx = this.getMidpoint().x +
            (FlxG.mouse.x - this.getMidpoint().x) / this.scale.x;
        var adjustedy = this.getMidpoint().y +
            (FlxG.mouse.y - this.getMidpoint().y) / this.scale.y;
        var adjustedCursorPos = new FlxPoint(adjustedx, adjustedy);
        return pixelsOverlapPoint(adjustedCursorPos);
    }



}

class Crewmember extends Object {
    function look(){
        currentRoom.getCharacter("player").say ("What happen to the crew?");
    }
    public function new(x,y){
        super(x,y);
        customName = "Crewmemebr";
    }

}

class Crate extends Object {
    function look(){
        currentRoom.getCharacter("player").say("I think there is a hammer in here");
        var hammer = new Hammer(0,0);
        FlxG.state.add (hammer);
        R.inv.add (hammer);
        var crate = new EmptyCrate (106,39);
        currentRoom.objects.push(crate);
        FlxG.state.add (crate);
        kill();
        currentRoom.objects.remove(this);
    }

}
class EmptyCrate extends Object {
    function new (x,y){
        super(x,y,"crate");
        customName = "Empty Crate";
    }
}

class Hammer extends Objects.SmallObject{

}


