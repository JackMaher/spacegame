package;
using Definitions;
using Objects;
using Characters;

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
                    new RoomTrigger(-10,"Hallway1",100,15)];
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
                        new RoomTrigger(120,"Hallway4",0,15)];
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
        ];
    }
}

class Hallway5 extends Room {

    public function new() {
        super();
    }

    override public function create() {
        objects = [new LeftDoor(-11,0),
                  new Sodsbury(92,20),
                   new Player(15,15),
                   new SmallObject(40,0),
                   new RoomTrigger(-10,"Hallway4",100,15),
                   new RightDoor (106,0),
                   new Block(116),
                   new Cockdoor(43,8, "Hallway2",1,1)];
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
        objects = [ new Player(30,32),
                    new Crewmember(4,34),
                    new Crate(106,39),
                    new ShipDoor(17,25,"Hallway2",31,15),
                    new Block(2)];
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
        ];
    }

}


