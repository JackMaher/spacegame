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
class Person1 extends Character{
    function new (x,y){
        super(x,y);
        visible = false;
        hidden = true;
    }
}

class Person2 extends Character{
    function new (x,y){
        super(x,y);
        visible = false;
        hidden = true;
    }
}

class Person3 extends Character{
    function new (x,y){
        super (x,y);
        visible = false;
        hidden = true;
    }
}

class Person4 extends Character{
    function new(x,y){
        super(x,y);
        visible = false;
        hidden = true;
    }
}

class Person5 extends Character{
    function new(x,y){
        super(x,y);
        visible = false;
        hidden = true;
    }
}

class Cutcreen extends Object {
    public var _fadeout = false;
    function new(x,y){
        super(x,y);
        layer = FORE;
        alpha = 0;
    }
    function cutStart(){
        //when alpha hits 1
        var p1 = cast(currentRoom.get("person1"),Person1);
        var p2 = cast(currentRoom.get("person2"),Person2);
        var p3 = cast(currentRoom.get("person3"),Person3);
        var p4 = cast(currentRoom.get("person4"),Person4);
        var p5 = cast(currentRoom.get("person5"),Person5);


        function cut14(){
            game.switchRoom("Cargo",128,32);
            game.canInteract = true;
        }

        function cut13(){
            FlxG.camera.shake(0.005,1);
            p5.say("Ship Under Attack, generators have been damaged, helium reserve depleted, low reserve of Oxygen.",FlxColor.RED,4);
            wait(4,cut14);

        }

        function cut12(){
            p4.say("-Some hours later-");
            wait(3,cut13);
        }

        function cut11(){
            player.say("Oh god what's going on");
            wait(4,cut12);
        }


        function cut10(){
            p3.say("You there get all these crates onto our ship before anyone shows up", FlxColor.GREEN,4);
            wait(5,cut11);
        }

        function cut9(){
            FlxG.camera.shake(0.005,0.5);
            p3.say("Crew is taken care of and the ship is set to crash into the nearby metor, the perfect crime", FlxColor.GREEN,4);
            wait(5,cut10);
        }

        function cut8(){
            FlxG.camera.shake(0.005,0.5);
            p1.say("The ship is under attack, find somewhere to hide",FlxColor.PURPLE);
            wait(5,cut9);
        }

        function cut7(){
            p2.say("Oh ok",FlxColor.BLUE,2);
            wait(3,cut8);
        }

        function cut6(){
            player.say("Nothing",null,1);
            wait(1,cut7);
        }

        function cut5(){
            p2.say("What was that?",FlxColor.BLUE,1);
            wait(1,cut6);
        }

        function cut4(){
            player.say("OW",null,1);
            wait(1,cut5);
        }

        function cut3(){
            FlxG.camera.shake(0.005,0.2);
            p2.say("Done",FlxColor.BLUE,1);
            wait(1,cut4);
        }

        function cut2(){
            p2.say("Christ this is heavy",FlxColor.BLUE,4);
            wait(4,cut3);
        }

        function cut1(){
            p1.say("Ok Gary, move that crate over there",FlxColor.PURPLE,3);
            wait(3,cut2);
        }


        wait(2,cut1);

    }

    public override function update (d){
        super.update(d);
        if (_fadeout == true){
            alpha += 0.005;
            if(alpha >= 1){
                _fadeout = false;
                cutStart();
            }
        }
    }
}

class Fadein extends Object{
    public var _fadein = true;
    var done = false;
    function new(x,y){
        super(x,y);
        layer = FORE;
        alpha = 1;
    }
    public override function update (d){
        super.update(d);
        if (_fadein == true && done == false){
            alpha -= 0.005;
            if(alpha <= 0){
                _fadein = false;
                done = true;
                Game.countdown.start();
            }
        }
    }
}

class Pship extends Character{
    function new(x,y){
        super(x,y);
        layer = FORE;
        visible = false;
    }
}

class FadeinSpace extends Object{
    public var _fadeinSpace = true;
    public var done = false;
    function new(x,y){
        super(x,y);
        layer = FORE;
        alpha = 1;
    }
    public override function update (d){
        super.update(d);
        if (_fadeinSpace == true && done == false){
            alpha -= 0.005;
            if(alpha <= 0){
                _fadeinSpace = false;
                done = true;
                cast(currentRoom,Spacebattle).Enterspace();
            }
        }
    }
}

class Reporter extends Character{
    public var _reporter = false;
    function new (x,y){
        super(x,y);
        layer = FORE;
        hidden = true;
        visible = false;
    }
}

class Deadfadeout extends Object {
    public var _deadfade = true;
    var _rp:Reporter;
    var done = false;
    function new(x,y){
        super(x,y);
        layer = FORE;
        alpha = 0;
    }

            function rp3(){
            _rp.say(" more on this story at 9.",FlxColor.RED,5);
            }
            function rp2(){
                _rp.say(" casuing a devastating explosion killing everyone onbord,",FlxColor.RED,5);
                wait(5,rp3);
            }
            function rp1(){
                _rp.say("Breaking News, a Roadmanion Ship containing two Roadmanion and a Human has crashed into 'Spaceport x9521'",FlxColor.RED,5);
                wait(5,rp2);
            }
    public override function update (d){
        super.update(d);
        if (_deadfade == true && done == false){
            alpha += 0.005;
            if(alpha >= 1){
                var rp = new Reporter (0,0);
                currentRoom.objects.push(rp);
                rp.x = FlxG.width/2-rp.width/2;
                rp.y = Game.ROOM_HEIGHT/2-rp.height/2+Game.ROOM_TOP;
                _rp=cast(currentRoom.get("reporter"),Reporter);
                done = true;
                wait(2,rp1);
            }
        }
    }
}

class Bedroompc extends Character {
    var startedChat:Bool = false;
    function new(x,y){
        super(x,y);
        customName = "PC";
        layer = BACK;
    }
    function look(){
        player.say("My vintage Cathode Ray Tubed Personal Computer");
    }
    function use(){
        if (pixelDistance(player) < 4 && startedChat == false){
            startedChat = true;
            say("Dear Richard Sparrow",FlxColor.GRAY,4);
            say("I regret to inform you that we will no longer be continuing with your",FlxColor.GRAY,4);
            say("employment at Dr Popp Incorprated, with immediate effect.",FlxColor.GRAY,4);
            game.canInteract = false;
            wait(5,bedroom1);
        }
        if (pixelDistance(player)>5 && startedChat == false){
            player.say("I'm too far away to use this");
        }
    }
    function bedroom1(){
        say("Please let me know of any belongings you may have",FlxColor.GRAY,4);
        say( "left in the office and I will get these to you",FlxColor.GRAY,4);
        wait(6,bedroom2);
    }
    function bedroom2 (){
        player.say("Great, fired again! Steven is such a jerk. it wasn't even that serious,",null,4);
        player.say(" just one minor engine-room meltdown!",null,4); 
        wait (5, bedroom3);
    }
    function bedroom3(){
        player.say("I don't know why I even bother staying around here,",null,4);
        player.say(" I might as well ship myself off to the farthest corner of the galaxy",null,4);
        player.say(" and start again. ",null,4);
        wait (5, bedroom4);
    }
    function bedroom4(){
        //player.say("off to the farthest corner of the galaxy and start again.");
        player.say(" This crate looks almost my size...");
        startedChat = false;
        game.canInteract = true;
    }
    
}

class Bedroomcrate extends Object{
    public var _bedtrigger:Bool = false;
    function new (x,y){
        super(x,y);
        customName = "Crate";
        layer = FORE;
    }
    function look(){
        player.say("Am I really gonna do this?");
    }
    function use(){
        if(_bedtrigger== true){
            player.say("Here we go");
        }
    }
    public function collision(){
        player.say("Here we go",null,1.5);
    }
}

class Bedtrigger extends Object{
    var done = false;
    function new (x,y){
        super(x,y);
    }
    override public function update (d){
        super.update(d);
        if (pixelDistance(player) ==0 && done == false){
            cast(currentRoom.get("Crate"), Bedroomcrate).collision();
            done = true;
            player._canControl = false;
            game.canInteract = false;
            cast(currentRoom.get("cutcreen"),Cutcreen)._fadeout = true;
            //wait(1,_change);
        }
    }
}

class Lucaslena extends Object{
    function new (x,y){
        super (x,y);
        customName = "Poster";
    }
    function look(){
        player.say("I dreamt of becoming space adventurer like Lucas Lena... maybe one day");
    }
}
class Poster1 extends Object {
    function new (x,y){
        super (x,y);
        customName = "Poster";
    }
    function look(){
        player.say("'Space the final frontier'");
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
        if (pixelDistance(player) < 3){
            player.say("This is no time to sleep");
        }
        else {
            player.say("I'm too far away to use this");
        }
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
        player.say("Oh a hammer!");

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
    function look(){
        player.say("It looks like they've stolen a fair bit of Cargo.");
    }
}

class Crate3 extends Object {
    function new(x,y){
        super (x,y);
        customName = "Cargo";
        layer = BACK;

    }
    function look(){
        player.say("Looks like they started to run out of places to put the cargo");
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

class Rust2 extends Object{
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

//Hallway5
class Cocksign extends Object{
    function new(x,y){
        super(x,y);
        customName = "Cockpit";
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
            player.walkTo(other.tileX() + 7, dead1);

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
        if (other.n =="Rust"){
            player.say("It's gonna take more than a hammer to fix this rust.");
        }
        if (other.n =="Cargo Container"){
            player.say("I dont want to damage this Cargo any futher than it already has");
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
        var _screwsods = function() {
            var _sods = cast(currentRoom.get("sodsbury"),Sodsbury);
            _sods.say("Ow, stop that",FlxColor.ORANGE);
        }
            if(other.n=="Controls" && game._underattack == true){
                game.switchRoom("Spacebattle",128,32);
            }
            if(other.n == "sodsbury"&&cast(other,Sodsbury).alive == true){
            player.walkTo(other.tileX()-4, _screwsods);
            }
            if(other.n == "sodsbury"&&cast(other,Sodsbury).alive == false){
                player.say("That would be needlessly cruel");
            }
        }

}

class Table extends Object {
    function new(x,y){
        super (x,y);
        customName = "Table";
    }
    function look(){
        player.say("This must be where the crew ate, all two of them");
    }
}
class Tv extends Object{
    function new(x,y){
        super(x,y);
        customName = "HoloTV";
    }
    function look (){
        player.say("HoloTV must be broken");
    }
}
class LeftDoor extends Object {
    function new(x,y) {
        super(x,y);
        customName = "";
        layer = FORE;
    };
}
class Sleepingpod extends Object {
    function new(x,y){
        super(x,y);
        customName = "Sleeping Pod";
    }
    function look (){
        player.say("Atleast he passed away while sleeping");
    }
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
        visible = false;
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
        layer = BACK;
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
        layer= BACK;
    }

    function _warning2(){
        game.canInteract = true;
    }
    public function _warning(){
        say("Captain to Cockpit, the ship is under attack", FlxColor.RED);
        game._underattack = true;
        wait(1,_warning2);

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
        customName = "Railings";
    }
    function look(){
        player.say("These railings are barely being held together");
    }
}

class Powercrate extends Object{
    function new(x,y){
        super(x,y);
        customName = "Cargo";
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
        customName = "Empty Cargo";
    }
}

class Cockwindow extends Object {
    public var _attack:Bool = false;
    function new (x,y){
        super(x,y);
        origin.set(0,0);
        loadGraphic("assets/images/cockwindow.png", true, 59,54);
        animation.add("default",[0],1,false);
        animation.add("attack",[1,2,3,4,5],5,true);
        customName = "Bay Window";
        updateHitbox();

    }
    public override function update(d){
        super.update(d);
        if (_attack == false){
            animation.play("default");
        }
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
        player.option("-Yaourself- I need to get this ship moving", attack3);
    }
    function attack3() {
        wait(3,attack3_wait);
    }
    function attack3_wait(){
        say("Set the ship’s phasers to the murder setting in 10...",null,5);
        wait(5,attack3_wait1);
    }
    function attack3_wait1(){
        FlxG.camera.shake(0.001,8);
        player.say("I gotta do something quick before I'm blown out of the air");
        wait(8,attack3_wait2);
    }
    function attack3_wait2(){
        var cw = cast(currentRoom.get("Bay Window"),Cockwindow);
        FlxG.camera.shake(0.005,2);
        cw._attack = true;
        cw.animation.play("attack");
        wait(2,endgame1);
    }
    function endgame1(){
        FlxG.camera.shake(0.01,3);
        player.ending1();
    }

}


class Rustship extends Object{
    function new (x,y){
        super (x,y);
    }
    public override function update (d){
        super.update(d);
        x+=10;
        y+=8;
    }
}

class Eship extends Object{
    function new (x,y){
        super (x,y);
    }
}

class Spacestation extends Object {
    function new (x,y){
        super (x,y);
        origin.set(0,0);
        loadGraphic("assets/images/spacestation.png",true, 24,24);
        animation.add("_idle", [0,1,2,3,4,5],4,true);
        animation.play("_idle");
        layer = FORE;
        updateHitbox();
        customName = "Spaceport";
    }
    public override function update(d){
        super.update(d);
        animation.play("_idle");
    }
}

class Pshipstop extends Character {
    function new (x,y){
        super (x,y);
    }
}

class Spaceframe extends Object {
    function new (x,y){
        super (x,y);
        layer = FORE;
    }
}