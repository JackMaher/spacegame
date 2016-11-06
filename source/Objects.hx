package;
using Definitions;
using Rooms;
import flixel.FlxSprite;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.math.FlxPoint;

class Key extends SmallObject {
}


class Crewmember extends Object {
    function look(){
        player.say ("What happen to the crew?");
    }
    public function new(x,y){
        super(x,y);
        customName = "Crewmemebr";
    }

}

class Crate extends Object {
    function look(){
        player.say("I think there is a hammer in here");

        R.inv.add(new Hammer(0,0));
        currentRoom.addObject(new EmptyCrate(106, 39));
        currentRoom.remObject(this);
    }

}
class EmptyCrate extends Object {
    function new (x,y){
        super(x,y,"crate");
        customName = "Empty Crate";
    }
}

class Hammer extends SmallObject{

}


