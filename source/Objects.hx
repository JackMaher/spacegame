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

        if (pixelDistance(player) < 5){
        R.inv.add(new Hammer(0,0));
        currentRoom.addObject(new EmptyCrate(106, 39));
        currentRoom.remObject(this);
        player.say("I reached into the crate and grabbed a hammer");

        }
        else{
            player.say("This cargo crate has been left slightly open");
        }
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

class LeftDoor extends Object {
    function new(x,y) {
        super(x,y);
        customName = "";
        layer = FORE;
    };
}

class CargoDoor extends Door {
    function new(x,y) {
        super(x,y,"cargodoor");

        //Graphics stuff
        loadGraphic("assets/images/cargodoor.png",true, 19,25);
        animation.add("default", [3], 0);
        animation.add("open", [2,0,1], 8, false);
        animation.add("close", [0,2,3], 8, false);
        animation.play("default");

        updateHitbox();

        // Essential bits of info
        newRoom = "Hallway5";
        newPlayerX = 47;
        newPlayerY = 15;
    }
}

