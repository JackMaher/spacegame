package;
using Definitions;
using Rooms;
using Type;
using Characters;
using TerminalScreen;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.util.FlxColor;
import flixel.math.FlxPoint;

class Key extends SmallObject {
}

//Bedroom
class Bedroompc extends Character {
    var startedChat:Bool = false;
    function new(x,y){
        super(x,y);
        customName = "PC";
        layer = BACK;
    }
    function use(){
        if (pixelDistance(player) < 5 && startedChat == false){
            startedChat = true;
            say("Dear Richard Sparrow",FlxColor.MAGENTA);
            say("I regret to inform you that we will no longer be continuing with your",FlxColor.MAGENTA);
            say("employment at Dr Popp Incorprated, with immediate effect.",FlxColor.MAGENTA);
            wait(5,bedroom1);
        }
    }
    function bedroom1(){
        say("Please let me know of any belongings you may have",FlxColor.MAGENTA);
        say( "left in the office and I will get these to you",FlxColor.MAGENTA);
        wait(4,bedroom2);
    }
    function bedroom2 (){
        player.say("Great, fired again! Steven is such a jerk. it wasn't even that serious,");
        player.say(" just one minor engine-room meltdown!"); 
        wait (4, bedroom3);
    }
    function bedroom3(){
        player.say("I don't know why I even bother staying around here,");
        player.say(" I might as well ship myself off to the farthest corner of the galaxy");
        player.say(" and start again. ");
        wait (4, bedroom4);
    }
    function bedroom4(){
        //player.say("off to the farthest corner of the galaxy and start again.");
        player.say(" This crate looks almost my size...");
        startedChat = false;
    }
}

class Bedroomcrate extends Object{
    function new (x,y){
        super(x,y);
        customName = "Crate";
    }
    function look(){
        player.say("Am I really gonna do this?");
    }
}

class Lucaslena extends Object{
    function new (x,y){
        super (x,y);
        customName = "Poster";
    }
    function look(){
        player.say("I dreamed of becoming space adventurer like Lucas Lena, maybe one day");
    }
}

class Bed extends Object{
    function new (x,y){
        super (x,y);
        customName = "Bed";
    }
    function look(){
        player.say("I should really make my bed");
    }
    function use(){
        player.say("This is no time to sleep");
    }
}

//Cargo


class Crewmember extends Object {

    function look(){
        player.say ("What happen to the crew?");
    }
    public function new(x,y){
        super(x,y);
         customName = "Crewmember";
    }

}

class Crate extends Object {
    function new (x,y){
        super(x,y);
        customName = "Crate";
    }
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

class Baydoor extends Object {
    function new (x,y){
        super (x,y);
        customName = "Bay Door";
    }

    function look (){
        player.say("This must be how the ship takes in cargo.");
    }
}

class Crate2 extends Object {
    function new(x,y){
        super (x,y);
        customName = "Cargo Container";
        layer = FORE;

    }
}


//Hallway2
class Rust1 extends Object {
    function new (x,y){
        super (x,y);
        customName = "Rust";
    }

    function look (){
        player.say("This ship has seen better days");
    }
}

//Hallway3
class Window1 extends Object {
    function new (x,y){
        super (x,y);
        customName = "Window";
    }

    function look (){
        player.say("I just wanted to go to space.");
    }
}

//Hallway4

class Window2 extends Object{
    function new(x,y){
        super (x,y);
        customName = "Window";
    }
    function look (x,y){
        player.say("I can see my house from here");
    }
}

class Sign extends Object{
    function new (x,y){
        super(x,y);
        customName = "Generators Below";
    }
    function look(){
        player.say("I guess the generators are below");
    }
}


//Small Objects

class Hammer extends SmallObject{
    function new (x,y){
        super(x,y);
        customName = "Hammer";
    }
    function look(){
        player.say("This hammer could pack quite a punch");
    }

    function useOn(other:Object) {

            var _stopSwing = function(){
                player._swing = false;
                player._canControl = true;
            }

                var move1 = function() {
                if(other.n == "sodsbury"){
                    cast(other,Sodsbury).kill();
                }
            }

            var _startSwing = function (){
                player._swing = true;
                if(other.n == "sodsbury") player.flipX = false;
                wait(0.5, move1);
                wait(1,_stopSwing);
            }


        if(other.n == "Crewmember") {
            function _crewmember(){
                player.say("Yep... definitely dead");
            }
            function _crewmemberSwing(){
                _startSwing();
                wait(1,_crewmember);
            }
            function dead1() {
                player._canControl = false;
                player.flipX = true;
                player.say("Is he dead?");
                wait(1,_crewmemberSwing);
            }
            player.walkTo(other.tileX() + 10, dead1);

        }
        if(other.n =="Manhole"){
            trace("bong");
            cast(other,Manhole).Open();
        }

        if (other.n == "sodsbury"){
            player.walkTo(other.tileX()-4, _startSwing);
            cast(other,Sodsbury).flipX = false;
            player._canControl = false;
            cast(other,Sodsbury).walk = null;
        }
        if (other.n == "Bay Door"){
            player.say("Looks like this door has suffer with abit more than hammer dents");
        }

        if(other.n == "Window"){
            player.say("That doesnt seem like a good idea");

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
            Powerpc._powerOn = true;
        }
    }
}

class Screwdriver extends SmallObject{
    function look(){
    player.say("If I find some loose screws I'll have the right tool for the job");
    }
    function useOn(other:Character){
        if(other.n=="Controls" && game._underattack == true){
            FlxG.switchState(new WinGameState());
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
        customName = "Manhole";
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
    public static var _powerOn:Bool = false;
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

class Cockdoor extends Door{
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
        locked = true;

    }
    override public function update(d){
        super.update(d);
        if (Powerpc._powerOn == true){
            locked = false;
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
    public function _warning(){
        say("Captin to Cockpit, the ship is under sttack", FlxColor.RED);
        game._underattack = true;

    }


    function look(){
        player.say("This must be the Captins terminal.");
    }
    function use(){
        if (Powerpc._powerOn == true){
            new TerminalScreen();
        }
        else {
        player.say("This terminal has no power.");
    }
    }
}

class Railing extends Object{
    function new(x,y){
        super(x,y);
        layer = FORE;
    }
}

class Powercrate extends Object{
    function new(x,y){
        super(x,y);
    }
    function use(){
        if (pixelDistance(player) < 5){
        R.inv.add(new Screwdriver(0,0));
        currentRoom.addObject(new EmptyCrate1(180,53));
        currentRoom.remObject(this);
        }
    }
}

class EmptyCrate1 extends Object {
    function new (x,y){
        super(x,y,"powercrate");
        customName = "Empty Crate";
    }
}

class Cockwindow extends Object {
    function new (x,y){
        super(x,y);
        customName = "Bay Window";
    }
}

class Cockpc extends Character{
    var startedChat:Bool = false;
    function new (x,y){
        super(x,y);
        customName = "Controls";
    }
    function use(x,y){
        if (game._underattack == true && startedChat == false){
            player.animation.play("idle");
            startedChat = true;
            say("Captain Schmuggler we have you surrounded.",null,4);
            say("There no chance of you getting away this time!",null,4);
            wait(4, characterResponds);
        }
    }
    function characterResponds(){
        player.say("The Captain is dead, I'm the only one person alive",null,4);
        wait(4, attack1);
    }
    function attack1(){
        say("You think you can fool us so easily Schmuggler?",null,4);
        say("You Roadmanion have attacked our ships for the last time!",null,4);
        wait(4, characterResponds1);
    }
    function characterResponds1(){
        player.say("I'm not a Roadmanion, I'm human I stowaway on the ship before the crew died!",null,4);
        wait (4, attack2);
    }
    function attack2(){
        say("You think you can use the \"I'm just a human stowaway on the ship\"",null,6);
        say(" excuses? That’s the oldest trick in the book",null,6);
        say("Prepare to meet your maker Schmuggler",null,6);
        wait(6,characterResponds2);
    }
    function characterResponds2(){
        player.option("Please, you have to believe me",attack3);
        player.option("See you in hell",attack3);
        player.option("*yourself* I need to get this ship moving", attack3);
    }
    function attack3() {
        wait(3,attack3_wait);
    }
    function attack3_wait(){
        say("Set the ship’s phasers to the murder setting...",null,5);
        wait(7,endgame1);
    }
    function endgame1(){
        FlxG.switchState(new EndGameState());
    }

}
