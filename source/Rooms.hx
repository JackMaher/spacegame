package;
using Definitions;
using Objects;
using Characters;

using Lambda;
using Reflect;
using Type;
import flixel.FlxG;

class Hallway5 extends Room {

    public function new() {
        super();
    }

    override public function create() {
        objects = [new Sodsbury(92,21),
                   new Player(15,15),
                   new SmallObject(40,0)];
    }
    function enter() {
        getCharacter("sodsbury").walkToObject("player");
    }

}

class Cargo extends Room{
    public function new(){
        super();
    }
    override public function create (){
        objects = [new Player(30,32),
                    new Crewmember(4,34),
                    new Crate(106,39),];
    }

}
