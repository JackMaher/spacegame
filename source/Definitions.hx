package;
using Reflect;
using Lambda;
using Type;
using Characters;
using Speech;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
using StringTools;

class Character extends Object {

    var walkSpeed:Float = 5;
    var walk:Null<{pos:Float,then:Void->Void}> = null;
    public var speeches:Array<Speech>=[];
    public var dialogs:Int = 0;

    public function new(x:Int,y:Int):Void {
        super(x,y);
        layer = CHAR;
    }

    override public function update(d):Void {
        if(walk != null) {
            if(Math.abs(walk.pos-x) < walkSpeed) {
                x = walk.pos;
                var pwalk = walk;
                walk = null;
                if(pwalk.then != null) pwalk.then();
            }
            else x += walkSpeed * (walk.pos-x>0?1:-1);
        }

        updateHitbox();
        //offset.x +=((x-currentRoom.x) % Game.SCALE_FACTOR);

        for(i in 0...speeches.length) {
            var s = speeches[i];
            s.text.visible = true;
            s.x = x+width/2-s.width/2;
            s.y = y-(0.3+speeches.length-i)*Speech.SIZE;
        }

        super.update(d);

    }

    public function walkToObject(ne:String, ?dist:Null<Float> = 0, ?then:Void->Void):Void {
        var ob = currentRoom.get(ne);
        var nx = 0.0;
            if(x < ob.x - dist - width)
                nx = ob.x - dist - width;
            else if(x > ob.x + ob.width + dist)
                nx = ob.x + ob.width + dist;
            else
                nx = x;
        walkTo(nx, then);
    }

    public function walkTo(pos:Float, ?then:Void->Void):Void {
        walk = {pos:roomPos(pos,0).x, then:then};
    }

    public function say(s:String) {
        speeches.push(cast FlxG.state.add(new Speech(s,this)));
    }

    public function option(s:String, ?then:Void->Void):Void {
        if(dialogs == 0) {
            for(s in speeches)
                s.kill();
            speeches = [];
        }
        speeches.push(cast FlxG.state.add(new DialogOption(
            s,this,speeches.length+1,then)));
    }
    public function endOptions() {
        dialogs = 0;
    }

}

class Door extends Object {

    var newRoom:String="";
    var newPlayerX:Int=0;
    var newPlayerY:Int=0;
    var touched:Bool = false;
    public function new(x,y,?asset:String) {
        super(x,y,asset);
        customName = " ";
    }

    public override function update(d):Void {
        super.update(d);
        if(animation.finished) {
        if((pixelDistance(player)==0)) {
            if(animation.name!="open")animation.play("open");
            touched = true;
        }
        else if(touched)
            if(animation.name!="close")animation.play("close");
        }

    }

    function use() {
        if(pixelDistance(player) > 0) {
            player.say("I'm too far away from the door.");
        }
        else {
            go();
        }
    }

    function go() {
        if(newRoom=="" || (newPlayerX==0&&newPlayerY==0)) {
            throw "Not enough information to change room!";
        }
        cast(FlxG.state,Game).switchRoom(newRoom,newPlayerX,newPlayerY);
    }

}

class Trigger extends Object {

    public function new(X:Int) {
        super(X,0,"trigger");
        customName="";
    }

    public override function update(d):Void {
        super.update(d);
        if(pixelDistance(player) == 0)
            if(field("trigger") != null)
                callMethod(field("trigger"),[]);
    }

}

class Block extends Object {

    public function new(X:Int) {
        super(X,0,"block");
        customName="";
        immovable=true;
    }

    public override function update(d):Void {
        FlxG.collide(this,game.layers.get(CHAR));
        super.update(d);
    }

}

class Room extends Object {

    public var objects:Array<Object> = [];

    public function new() {
        super(0,0);
        layer = ROOM;
    }

    public function create() {}

    public function getX(X) {
        return FlxG.width/2 - width/2
            + X * Game.SCALE_FACTOR;
    }
    public function getY(Y) {
        return Game.ROOM_HEIGHT/2 - height/2
            + Y * Game.SCALE_FACTOR;
    }

    public function v_leave() {
        for(o in objects) {
            cast(FlxG.state,Game).layers.get(o.layer).remove(o);
        }
        if(field("leave") != null)
            callMethod(field("leave"), []);

    }

    public function v_enter() {
        for(o in objects) {
            cast(FlxG.state,Game).layers.get(o.layer).add(o);
        }
        if(field("enter") != null)
            callMethod(field("enter"), []);
    }

    override function roomPos(X:Float,y:Float) {
        return {x:FlxG.width/2-width/2,
            y:Game.ROOM_HEIGHT/2-height/2+Game.ROOM_TOP};
    }

    public function get(O:String):Object {
        var k = objects.find(function(o){return o.n==O;});
        if(k == null) throw ("no object "+O+" in room!");
        return k;
    }

    public function getCharacter(O:String):Character {
        var k = objects.find(function(o){return o.n==O;});
        if(k == null) throw ("no object "+O+" in room!");
        return cast(k,Character);
    }

    public function addObject(O:Object) {
        objects.push(O);
    }

    public function remObject(O:Object) {
        objects.remove(O);
        O.destroy();
    }

}

class SmallObject extends Object {
    public var inInventory:Bool = false;

    override public function isCursorOverPixels():Bool {
        return overlapsPoint(FlxG.mouse.getPosition());
    }

    public function v_useOn(o:Object) {
        if(field("useOn")!= null) {
            callMethod(field("useOn"), [o]);
        }
    }

    function use() {
        if(inInventory) {
            game.objUsing = this;
        }
    }

}

class Object extends FlxSprite {

    public var n(get,never):String;
    public var customName:String="~";
    public var currentRoom(get,never):Room;
    public var player(get,never):Player;
    public var layer(default,set):Layer;
    public var game(get,never):Game;
    var gameX:Int;
    var gameY:Int;


    public function new(X:Int, Y:Int,?asset:String) {
        super();
        gameX = X;
        gameY = Y;
        if(asset == null) loadGraphic('assets/images/$n.png');
        else              loadGraphic('assets/images/$asset.png');
        scale.set(Game.SCALE_FACTOR,Game.SCALE_FACTOR);
        updateHitbox();
        var pos = roomPos(gameX,gameY);
        x = pos.x;
        y = pos.y;
        layer = BACK;

    }

    override public function update(d) {
        super.update(d);
    }

    public function v_look() {
        if(field("look") != null) callMethod(field("look"), []);
    }
    public function v_use() {
        if(field("use") != null) callMethod(field("use"), []);
    }

    /* Helper Functions */

    // Shorthand for name of object.
    public function get_n() {
        if(customName != "~") return customName;
        return getClass().getClassName().toLowerCase();
    }

    public function get_currentRoom() {
        return cast(FlxG.state,Game).currentRoom;
    }
    public function get_game() {
        return cast(FlxG.state,Game);
    }

    public function get_player() {
        return cast(currentRoom.get("player"), Player);
    }

    public function set_layer(L:Layer) {
            var g = cast(FlxG.state,Game);
            for(l in g.layers.iterator()) l.remove(this);
            g.layers.get(L).add(this);

        return layer = L;
    }

    //Work out where this object should be placed.
    public function roomPos(X:Float,Y:Float) {
        return {x:currentRoom.x + X*Game.SCALE_FACTOR,
                y:currentRoom.y + Y*Game.SCALE_FACTOR};
    }

    public function isCursorOverPixels():Bool {
        var adjustedx = this.getMidpoint().x +
            (FlxG.mouse.x - this.getMidpoint().x) / this.scale.x;
        var adjustedy = this.getMidpoint().y +
            (FlxG.mouse.y - this.getMidpoint().y) / this.scale.y;
        var adjustedCursorPos = new FlxPoint(adjustedx, adjustedy);
        return pixelsOverlapPoint(adjustedCursorPos);
    }

    public function pixelDistance(Other:Object):Int {
        if(x+width>Other.x && Other.x+Other.width > x) return 0;
        else if(x+width<=Other.x) return cast (Other.x-x-width)/Game.SCALE_FACTOR;
        else                      return cast (x-Other.x-Other.width)/Game.SCALE_FACTOR;
    }



}

enum Layer {
    ROOM;
    BACK;
    CHAR;
    FORE;
}
