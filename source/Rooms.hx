package;
using Definitions;
using Objects;
using Characters;
using Game;
using Lambda;
using Reflect;
using Type;
import flixel.FlxG;

class Hallway1 extends Room{
    public function new(){
        super();
    }
    override public function create (){
        objects = [new RoomTrigger(120,"Hallway2",0,15),
                        new RightDoor (106,0),
                        new LeftDoor(-11,0),
                        new ShipDoor(20,8,"Captinsroom", 112,29),
                        new Player(0,0)];
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
                        new Window1(36,8)];
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
                   new SmallObject(40,0),
                   new RoomTrigger(-10,"Hallway4",100,15),
                   new RightDoor (106,0),
                   new Block(116),
                   new Cockdoor(43,8, "Cockpit",17,14)];
    }
    function enter() {
        //getCharacter("sodsbury").walkToObject("player");
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
                    new Block(147)];
    }

}

class Captinsroom extends Room{
    public function new(){
        super();
    }
    override public function create (){
        objects = [new Player(0,0),
                    new ShipDoor(103,22, "Hallway1",29,15),
                    new Terminal(18,25)];
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
                    new Powercrate(180,53)
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
                    new Cockpc(75,17)];
    }
    function enter (){
        if (game._underattack == true){
            addObject(new Cockwindow(86,0));
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
                    new Bed(55,30)
        ];
    }
}


