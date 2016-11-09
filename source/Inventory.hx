using Objects;
using Rooms;
using Definitions;
using Lambda;
import flixel.FlxBasic;
import flixel.group.FlxGroup;
import flixel.FlxG;

class Inventory extends FlxTypedGroup<SmallObject> {

    public var objects:Array<SmallObject> = [];
    public static inline var ROWS:Int = 1;
    public static inline var COLS:Int = 5;
    public static inline var SLOT_SIZE:Int = 60;

    static inline var X:Int = 1500;
    static inline var Y:Int = 850;

    public function new() {
        super();
    }

    override public function update(d):Void {
        super.update(d);
        positionAll();
    }

    public override function add(o:SmallObject):SmallObject {
        if(objects.indexOf(o) != -1) {
            trace(o.n + " already in inventory!");
            return o;
        }
        if(objects.length >= ROWS*COLS) {
            trace("Inventory full!");
            return o;
        }
        o.inInventory = true;
        var k = objects.push(o);
        return super.add(o);
    }

    public function removeByName(n:String) {
        var k = objects.find(function(o){return o.n==n;});
        if(k == null) throw (n +" not found");
        remove(k);
    }

    public override function remove(o:SmallObject,s:Bool=false):SmallObject {
        objects.remove(o);
        o.inInventory = false;
        positionAll();
        o.kill();
        return super.remove(o,s);
    }

    function positionAll() {
        var count=0;
        for(o in objects) if(cast(FlxG.state,Game).objUsing != o)
            position(o,count++);
    }

    function position(o:SmallObject, k:Int) {
        var xslot = k % COLS;
        var yslot = Math.floor(k / COLS);

        o.x = X + (xslot+0.5) * SLOT_SIZE - o.width/2;
        o.y = Y + (yslot+0.5) * SLOT_SIZE - o.height/2;
    }

}

