import Objects;
import flixel.FlxBasic;

class Inventory extends FlxBasic {

    public var members:Array<SmallObject> = [];
    public static inline var ROWS:Int = 1;
    public static inline var COLS:Int = 5;
    public static inline var SLOT_SIZE:Int = 32;

    static inline var X:Int = 100;
    static inline var Y:Int = 100;

    public function new() {
        super();
    }

    override public function update(d):Void {
        super.update(d);
    }

    public function add(o:SmallObject) {
        if(members.indexOf(o) != -1) {
            trace(o.n + " already in inventory!");
            return;
        }
        if(members.length >= ROWS*COLS) {
            trace("Inventory full!");
            return;
        }

        var k = members.push(o);
        position(o,k-1);
    }

    function position(o:SmallObject, k:Int) {
        var xslot = k % COLS;
        var yslot = Math.floor(k / COLS);

        o.x = X + (xslot+0.5) * SLOT_SIZE - o.width/2;
        o.y = Y + (yslot+0.5) * SLOT_SIZE - o.height/2;
    }

}

