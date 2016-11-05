package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import Objects;
import Rooms;
using Type;
using Reflect;

class Game extends FlxState {

    public static var ROOM_HEIGHT:Int;
    public static var ROOM_TOP:Int;
    public static var SCALE_FACTOR:Int = 8;
    public var currentRoom:Room;
    var rooms:Map<String, Room> = new Map();

    override public function create():Void {
        ROOM_HEIGHT = 800;
        ROOM_TOP = 50;

        add(R.inv); // adds the inventory to the screen

        switchRoom("Cargo");

        add(new FlxSprite(0,880).makeGraphic(FlxG.width,20,0xffffffff));

        super.create();
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        if(FlxG.keys.justPressed.ONE) switchRoom("Room");
        if(FlxG.keys.justPressed.TWO) switchRoom("Hallway1");
        if(FlxG.keys.justPressed.Q) Sys.exit(0);
    }

    public function switchRoom(R) {
        if(currentRoom != null) {
            currentRoom.v_leave();
            remove(currentRoom);
        }

        if(rooms.get(R) == null) {
            rooms.set(R, R.resolveClass().createInstance([]));
            currentRoom = rooms.get(R);
            rooms.get(R).create();
        }

        var room = rooms.get(R);
        currentRoom = room;

        add(room);
        room.v_enter();
    }
}
