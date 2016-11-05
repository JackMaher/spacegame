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

}

