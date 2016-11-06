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
        var hammer = new Hammer(0,0);
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

class Hammer extends SmallObject{

}


