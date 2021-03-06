package;
using Definitions;
using Objects;
using Characters;
using Game;
using Lambda;
using Reflect;
using Type;
import flixel.FlxG;
import flixel.util.FlxColor;

class Hallway1 extends Room{
    public function new(){
        super();
    }
    override public function create (){
        objects = [new RoomTrigger(120,"Hallway2",0,15),
                        new RightDoor (106,0),
                        new LeftDoor(-11,0),
                        new ShipDoor(20,8,"Captinsroom", 112,29),
                        new Player(0,0),
                        new Block(7),
                        new Table(59,21),
                        new Tv(59,8)];
    }
}

class Hallway2 extends Room{
    public function new(){
        super();
    }
    override public function create(){
        objects = [new LeftDoor(-11,0),
                    new Player(15,15),
                    new ShipDoor(29,8,"Cargo",20,33),
                    new RightDoor (106,0),
                    new RoomTrigger(120,"Hallway3",0,15),
                    new RoomTrigger(-10,"Hallway1",100,15),
                    new Rust1(78,24)];
    }
}

class Hallway3 extends Room{
    public function new(){
        super();
    }
    override public function create(){
        objects = [new Player(0,0),
                        new RoomTrigger(-10,"Hallway2",100,15),
                        new RightDoor (106,0),
                        new LeftDoor(-11,0),
                        new RoomTrigger(120,"Hallway4",0,15),
                        new Window1(36,8),
                        new Rust2(16,1)];

    }
}


class Hallway4 extends Room{
    public function new (){
        super();
    }
    override public function create (){
        objects = [new Player(0,0),
        new RoomTrigger(-10,"Hallway3",100,15),
        new RoomTrigger(120,"Hallway5",0,15),
        new Manhole(66,16),
        new RightDoor (106,0),
        new LeftDoor(-11,0),
        new Window2(22,5),
        new Sign(67,9)
        ];
    }
}

class Hallway5 extends Room {

    public function new() {
        super();
    }

    override public function create() {
        objects = [new LeftDoor(-11,0),
                  new Sodsbury(80,20),
                   new Player(15,15),
                   new Cocksign(65,13),
                   new RoomTrigger(-10,"Hallway4",100,15),
                   new RightDoor (106,0),
                   new Block(116),
                   new Cockdoor(43,8, "Cockpit",17,14),
                   new Crate3(78,10)];
    }
    function enter() {
        //getCharacter("Sodsbury").walkToObject("player");
    }

}

class Cargo extends Room{
    public function new(){
        super();
    }

    override public function create (){
        objects = [ new Player(128,32),
                    new Crewmember(4,34),
                    new Crate(106,39),
                    new ShipDoor(17,25,"Hallway2",31,15),
                    new Baydoor(42,6),
                    new Crate2(128,20),
                    new Block(2),
                    new Block(147),
                    new Fadein(0,0)];
    }

}

class Captinsroom extends Room{
    public function new(){
        super();
    }
    override public function create (){
        objects = [new Player(0,0),
                    new ShipDoor(103,22, "Hallway1",29,15),
                    new Terminal(38,25),
                    new Block (133),
                    new Block(8),
                    new Sleepingpod(4,9),];
    }
}

class Powerroom extends Room{
    public function new(){
        super();
    }
    override public function create (){
        objects = [new Player(0,0),
                    new Powerpc(140,67),
                    new Ladder(168,2),
                    new Powercrate(180,53),
                    new Block(192),
                    new Block(139),

        ];
    }

}

class Cockpit extends Room{
    public function new(){
        super();
    }
    override public function create (){
        objects = [new Player(1,1),
                    new ShipDoor(14,7,"Hallway5",46,16),
                    new Railing(4,27),
                    new Cockpc(75,17),
                    new Block (1),
                    new Block(76)];
    }
    function enter (){
        if (game._underattack == true){
            addObject(new Cockwindow(86,0));
            cast(get("ShipDoor"),ShipDoor).locked=true;
            cast(get("Controls"), Cockpc).startCov();
        }
    }
}

class Spacebattle extends Room{
    var _rp:Objects.Endingchar;
    public var _psstop:Pshipstop ; 
    public function new(){
        super();
        origin.x = 0;
        loadGraphic("assets/images/spacebattle.png", true, 195, 88);
        animation.add("go", [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31],4,false);
        animation.add("stop",[31],0);
        animation.add("start",[0],0);
        animation.play("start");
        updateHitbox();
        layer = FORE;
        x = roomPos(0,0).x;
        y = roomPos(0,0).y;
    }


    override public function create(){
        objects = [new Player(1,1),
                    new Spacestation(124,4),
                    new FadeinSpace(0,0),
                    new Pship(32,16),
                    new Pshipstop(143,25),
                    new Spaceframe(0,0),
                   new Ecutscene(0,0),
                   new Endingchar(95,43)

        ];
    }
    function cutscene8(){
        _rp.say("'More on this story at 8'", FlxColor.RED);
    }
    function cutscene7(){
        _rp.say("'We all owe Captain Gunn a massive thanks for being brave, a real life hero by his own accounts'",FlxColor.RED);
        wait(5,cutscene8);
    }
    function cutscene6(){
        _rp.say("'Tommy Gunn, snuck onto the Captain's ship with the intent on bringing his rain of terror to an end.'",FlxColor.RED);
        wait(5,cutscene7);
    }

    function cutscene5(){
        _rp = cast(currentRoom.get("EndingChar"),Endingchar);
        _rp.say("'Breaking News renowed pirate Captain Schmuggler was defeated todo along",FlxColor.RED);
        _rp.say(" with the rest of his crew in 1 on 1 combat with a humnoid today'",FlxColor.RED);
        wait (5,cutscene6);
    }
    function cutscene4(){
        cast(get("Ecutscene"),Ecutscene)._fadeout = true;
        wait(3,cutscene5);
    }

    function cutscene3(){
        _psstop.say("a honset life");
        wait(3,cutscene4);
    }
    function cutscene2(){
        _psstop.say("I guess I can start that new life I wanted");
        wait (3, cutscene3);

    }
    function cutscene1 (start){
        _psstop = cast(currentRoom.get("pshipstop"),Pshipstop);
        animation.finishCallback = null;
        animation.play("stop");
        _psstop.say("What do I do now?");
        wait(3,cutscene2);
    }
    function cutscene(){
        animation.play("go");
        animation.finishCallback = cutscene1;

    }

  public  function Enterspace (){
    var _ps=cast(currentRoom.get("pship"),Pship);
    if (cast(currentRoom.get("fadeinspace"),FadeinSpace).done == true){
        _ps.say("I guess I just jam this screw driver into here, and go?",null,5);
        FlxG.camera.shake(0.005,1);
        game.canInteract = false;
        wait(5,cutscene);
        }
    } 

}




class Bedroom extends Room{
    public function new(){
        super();
    }
    override public function create (){
        objects = [new Player(40,22),
                    new Bedroompc(10,22),
                    new Bedroomcrate(83,10),
                    new Lucaslena(15,7),
                    new Bed(55,30),
                    new Poster1(6,8),
                    new Bedtrigger(95,38),
                    new Block(98),
                    new Block(1),
                    new Cutcreen(0,0),
                    new Person1(48,23),
                    new Person2(61,21),
                    new Person3(12,23),
                    new Person4(50,33),
                    new Person5(50,6)
        ];
    }
}

class Cutscreen extends Room{
    function new (){
        super();
    }
    override public function create (){
        objects = [new Player (1,1),

        ];
    }
}

