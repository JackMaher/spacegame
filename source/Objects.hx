package;
using Definitions;
using Rooms;
using Type;
using Characters;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;

class Key extends SmallObject {
}


class Crewmember extends Object {
    function look(){
        player.say ("What happen to the crew?");
    }
    public function new(x,y){
        super(x,y);
    }

}

class Crate extends Object {
    function look(){
        player.say("This cargo crate has been left slightly open");

    }
    function use(){
        if (pixelDistance(player) < 5){
        R.inv.add(new Hammer(0,0));
        currentRoom.addObject(new EmptyCrate(106, 39));
        currentRoom.remObject(this);
        player.say("Ohhh a hammer!");

        }
        else{
            player.say("I can't reach that from here");
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
    function look(){
        player.say("This hammer could pack quite a punch");
    }

    function useOn(other:Object) {

            var _stopSwing = function(){
                player._swing = false;
            }

                var move1 = function() {
                cast(other,Sodsbury).kill();
                player._canControl = true;
            }

            var _startSwing = function (){
                player._swing = true;
                player.facing = FlxObject.RIGHT;
                wait(0.5, move1);
                wait(1,_stopSwing);
            }
        if(other.n == "crewmember") {
            player.say("That would be mean.");
        }
        if(other.n =="manhole"){
            cast(other,Manhole).Open();
        }

        if (other.n == "sodsbury"){
            player.walkTo(other.tileX()-4, _startSwing);
            cast(other,Sodsbury).flipX = false;
            player._canControl = false;
            cast(other,Sodsbury).walk = null;

            
            
        }
    }
}



class Bionicchip extends SmallObject{
    function look(){
        player.say("Not quite sure what todo with this");
    }
    function useOn(other:Object){
        if(other.n=="Computer"){
            cast(other,Powerpc).pcOn = true;
            R.inv.remove (this);
            cast(other,Powerpc).say("Bionic Chip installed, restoring power",FlxColor.GREEN);
        }
    }
}

class LeftDoor extends Object {
    function new(x,y) {
        super(x,y);
        customName = "";
        layer = FORE;
    };
}

class RightDoor extends Object {
    function new(x,y) {
        super(x,y);
        customName = "";
        layer = FORE;
    }
}

class RoomTrigger extends Trigger{
    var newRoom:String;
    var newX:Int;
    var newY:Int;

    function new (x,nRoom,nX,nY){
        super (x);
        newRoom = nRoom;
        newX = nX;
        newY = nY;

    }
    function trigger(){
        game.switchRoom(newRoom, newX, newY);
    }
}

class ShipDoor extends Door {
    function new(x,y,nRoom,nX,nY) {
        super(x,y,"cargodoor");

        //Graphics stuff
        loadGraphic("assets/images/cargodoor.png",true, 19,25);
        animation.add("default", [3], 0);
        animation.add("open", [2,0,1], 8, false);
        animation.add("close", [0,2,3], 8, false);
        animation.play("default");

        updateHitbox();

        // Essential bits of info
        newRoom = nRoom ;
        newPlayerX = nX;
        newPlayerY = nY;
    }
}

class Manhole extends Object {
    var Opened:Bool = false;
    public function new (x,y){
        super(x,y);
        loadGraphic("assets/images/manhole.png",true, 12, 17);
        animation.add("closed",[1], 0);
        animation.add("opened",[0],0);
        animation.play("closed");

        updateHitbox();
    }

    public function Open(){
        animation.play("opened");
        if(Opened != true){
            player.say("I pryed the cover opened");
        }
        Opened = true;
    }
    public function use(){
        if (Opened == true){ 
            game.switchRoom("Powerroom", 167,66);
        }
        else{
            player.say("This manhole has seen better days");
        }
    }

    function look(){
        if (Opened == false){
        player.say("The lid doesnt want to budge");
        }
        else {
            player.say("Its a long way down");
        }
    }

}

class Powerpc extends Character {
    public var pcOn:Bool = false;
    function new(x,y) {
        super(x,y);
        customName = "Computer";
        layer = FORE;
    }

    function use(){
        if(pcOn == false){
            say("Error Bionic Chip corrupted, replace with new chip",FlxColor.MAGENTA);
        }
        else {
             say("Power Restored", FlxColor.GREEN);
        }
    }
    function look(){

    if(pcOn == false){
            player.say("The screen seems to be flashing some error message");
        }
    }


}

class Ladder extends Object{
    function new(x,y){
        super(x,y);
    }
    public function use(){
        game.switchRoom("Hallway4",63,15);
    }

}

class Terminal extends Character{
    function new(x,y){
        super(x,y);
    }
    function look(){
        player.say("This must be the Captins terminal.");
    }
    function use(){
        player.say("This terminal has no power.");
    }
}