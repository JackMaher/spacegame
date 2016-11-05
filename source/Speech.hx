import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.FlxG;

class Speech extends FlxSpriteGroup {
    var text:FlxText;
    var age:Float=0;
    var speeches:Array<Speech>;
    public static var SIZE:Int = 48;
    public function new(s:String,speeches:Array<Speech>):Void {
        super();
        pixelPerfectRender = false;
        text = new FlxText(0,0,1000,s);
        text.setFormat("assets/fonts/PIXELADE.TTF");
        text.size = 40;
        text.alignment=CENTER;
        add(text);
        text.setBorderStyle(OUTLINE,0xff000000,2);
        this.speeches = speeches;
        visible = false;
    }
    override public function update(d) {
        visible = true;
        age+=d;
        if(age > 5) {
            kill();
            speeches.remove(this);
        }
        super.update(d);
    }
}
