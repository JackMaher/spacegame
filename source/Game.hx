package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.math.FlxMath;
import flixel.FlxCamera;
using Definitions;
import Objects;
import Rooms;
using Type;
using Reflect;
using Lambda;

class Game extends FlxState {

    public static var ROOM_HEIGHT:Int;
    public var _underattack = false;
    public static var ROOM_TOP:Int;
    public static var SCALE_FACTOR:Int = 8;
    public var currentRoom:Room;
    public var canInteract:Bool = true;
    var nameText:FlxText;
    public var objUsing:SmallObject;

    var roomLayer:FlxGroup=new FlxGroup();
    var backLayer:FlxGroup=new FlxGroup();
    var charLayer:FlxGroup=new FlxGroup();
    var foreLayer:FlxGroup=new FlxGroup();

    public static var countdown:Countdown;

    public var layers:Map<Definitions.Layer, FlxGroup> = new Map();
    var mouse:FlxSprite;

    var rooms:Map<String, Room> = new Map();

    var prevLeft:Bool=false;
    var prevRight:Bool=false;

    override public function create():Void {
        ROOM_HEIGHT = 800;
        ROOM_TOP = 50;


        add(roomLayer);
        add(backLayer);
        add(charLayer);
        add(foreLayer);
        layers.set(Definitions.Layer.ROOM, roomLayer);
        layers.set(Definitions.Layer.BACK, backLayer);
        layers.set(Definitions.Layer.CHAR, charLayer);
        layers.set(Definitions.Layer.FORE, foreLayer);

            switchRoom("Bedroom");

        add(mouse=new FlxSprite(FlxG.width/2,850).loadGraphic("assets/images/mouse.png"));
        mouse.origin.set(mouse.width/2,0);
        mouse.scale.set(SCALE_FACTOR,SCALE_FACTOR);

        nameText = new FlxText(0,FlxG.height-48,FlxG.width);
        nameText.setFormat("assets/fonts/PIXELADE.TTF");
        nameText.size = 40;
        add(nameText);

        add(countdown = new Countdown());

        add(R.inv); // adds the inventory to the screen

        super.create();
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        //if(FlxG.keys.justPressed.Q) Sys.exit(0);
        if(FlxG.keys.justPressed.F) currentRoom.getCharacter("player").say("Hello");

        if(canInteract) {
            var os = currentRoom.objects.copy();
            for(o in R.inv.objects) if(o != objUsing) os.push(o);
            var k = os.find(function(o) {
                return o.n != "player"
                    && o.n != ""
                    && o.hidden == false
                    && o.overlapsPoint(FlxG.mouse.getPosition())
                    && o.isCursorOverPixels();
            });
            if(k != null) {
                if(k.n != nameText.text) {
                    nameText.text = (if (k.hideName) "" else k.n);
                    nameText.fieldWidth = 1000;
                    nameText.offset.x = 0;
                    nameText.setBorderStyle(OUTLINE,0xff000000,2);
                    nameText.fieldWidth = nameText.textField.textWidth + 10;
                }
                nameText.x = k.x+k.width/2-nameText.width/2;
                nameText.y = k.y - 48;

            }
            else
                nameText.text = "";

            if(objUsing == null) {
                if(FlxG.mouse.justPressed)
                    if(k != null) k.v_use();
                if(FlxG.mouse.justPressedRight)
                    if(k != null) k.v_look();
            }
            else {
                var p = FlxG.mouse.getPosition();
                objUsing.x = p.x-objUsing.width/2;
                objUsing.y = p.y-objUsing.width/2;
                FlxG.mouse.visible = false;
                if(FlxG.mouse.justPressed){
                    if(k != null) {
                        objUsing.v_useOn(k);
                        objUsing = null;
                        FlxG.mouse.visible = true;
                    }
                }
                if(FlxG.mouse.justPressedRight) {
                    objUsing = null;
                    FlxG.mouse.visible = true;
                }
            }
        }
        nameText.visible = canInteract;

        if(FlxG.mouse.pressed != prevLeft) {
            if(FlxG.mouse.pressed)
                mouse.replaceColor(0xff9f9f9f, 0xffff7700);
            else
                mouse.replaceColor(0xffff7700, 0xff9f9f9f);
        }
        if(FlxG.mouse.pressedRight != prevRight) {
            if(FlxG.mouse.pressedRight)
                mouse.replaceColor(0xffa0a0a0, 0xffff7701);
            else
                mouse.replaceColor(0xffff7701, 0xffa0a0a0);
        }
        prevLeft  = FlxG.mouse.pressed;
        prevRight = FlxG.mouse.pressedRight;


    }

    public function switchRoom(R:String, ?pX:Int, ?pY:Int) {
        if(currentRoom != null) {
            currentRoom.v_leave();
            roomLayer.clear();
        }

        if(rooms.get(R) == null) {
            rooms.set(R, R.resolveClass().createInstance([]));
            currentRoom = rooms.get(R);
            rooms.get(R).create();
        }

        var room = rooms.get(R);
        currentRoom = room;
        roomLayer.add(room);

        var p = room.get("player");
        if(pX!=null&&pY!=null) {
            var pos = p.roomPos(pX,pY);
            p.x = pos.x; p.y=pos.y;
        }

        room.v_enter();

    }
}
