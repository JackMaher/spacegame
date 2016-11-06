package;
using Definitions;
using Objects;
using Characters;

using Lambda;
using Reflect;
using Type;
import flixel.FlxG;

class Hallway2 extends Room{
    public function new(){
        super();
    }
    override public function create(){
        objects = [new LeftDoor(-11,0),
                    new Player(15,15),
                    new ShipDoor(29,8,"Cargo",20,33),
                    new RightDoor (106,0),
                    new RoomTrigger(116,"Hallway3",0,15)];
    }
}

class Hallway3 extends Room{
    public function new(){
        super();
    }
    override public function create(){
        objects = [new Player(0,0),
                        new RoomTrigger(-10,"Hallway2",100,15)];
    }
}

class Hallway5 extends Room {

    public function new() {
        super();
    }

    override public function create() {
        objects = [new LeftDoor(-11,0),
                  new Sodsbury(92,21),
                   new Player(15,15),
                   new SmallObject(40,0)];
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
                    new ShipDoor(17,25,"Hallway2",31,16),];
    }

}
