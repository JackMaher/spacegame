import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.FlxG;
using Definitions;

class Speech extends FlxSpriteGroup {
    public var text:FlxText;
    var age:Float=0;
    var maxAge:Float = 3;
    var char:Character;
    public static var SIZE:Int = 48;
    public function new(s:String,char:Character,?col:Int=0xffffffff,?MaxAge:Float=3):Void {
        super();
        text = new FlxText(0,0,1000,s);
        text.setFormat("assets/fonts/PIXELADE.TTF");
        text.size = 40;
        text.alignment=CENTER;
        add(text);
        text.color = col;
        text.setBorderStyle(OUTLINE,0xff000000,2);
        this.char = char;
        text.fieldWidth = text.textField.textWidth + 10;
        text.updateHitbox();
        text.visible = false;
        maxAge = MaxAge;
    }
    override public function update(d) {
        age+=d;
        if(age > maxAge) {
            kill();
            char.speeches.remove(this);
            destroy();
            return;
        }
        super.update(d);
    }
}

class DialogOption extends Speech {

    var then:Void->Void;
    var num:Int;
    var content:String;

    public function new(s:String, char:Character,
            num:Int, ?then:Void->Void = null) {
        super('$num. $s',char, 0xffffff00,9999999);
        content = s;
        char.dialogs++;
        this.then = then;
        this.num  = num;
    }

    public override function update(d) {
        super.update(d);

        var opts = [null,FlxG.keys.justPressed.ONE,
                    FlxG.keys.justPressed.TWO,
                    FlxG.keys.justPressed.THREE,
                    FlxG.keys.justPressed.FOUR,
                    FlxG.keys.justPressed.FIVE];

        if(opts[num] || (FlxG.mouse.justPressed &&
            text.overlapsPoint(FlxG.mouse.getPosition())))
            hit();

    }

    function hit() {
        for(s in char.speeches) {
            if(s != this) {
                s.kill();
            }
        }
        maxAge = 3;
        age = 0;
        char.dialogs=0;
        char.speeches = [this];
        text.text = content;
        if(then != null) then();
    }

}
