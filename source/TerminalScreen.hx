package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.group.FlxGroup;
using StringTools;
using Definitions;
using Characters;
using Objects;

class TerminalScreen extends FlxGroup {
    //public var _warning = false;
    var _shipAttacked = false;
    var textRem:String;
    var bg:FlxSprite;
    var textbox:FlxText;
    var view(default,set):View;
    var x:Float;
    var y:Float;
    var emails:Array<Email>;
    var numKeys = ["ZERO","ONE","TWO","THREE","FOUR","FIVE","SIX","SEVEN","EIGHT","NINE"];
    var email:Int = 0;
    var pw:String = "";
    var online:Bool = false;
    var locked:Bool = false;

    public function new() {
        super();
        cast(FlxG.state,Game).layers.get(Layer.FORE).add(this);
        cast(FlxG.state,Game).canInteract = false;
        bg = new FlxSprite(0,0,"assets/images/terminalscreen.png");
        bg.scale.set(Game.SCALE_FACTOR,Game.SCALE_FACTOR);
        bg.updateHitbox();
        x = bg.x = FlxG.width/2-bg.width/2;
        y = bg.y = Game.ROOM_HEIGHT/2-bg.height/2+Game.ROOM_TOP;
        textbox = new FlxText(x+16,y+10,bg.width-32);
        textbox.setFormat("assets/fonts/PIXELADE.TTF");
        textbox.size = 36;

        add(bg);
        add(textbox);


        emails = [
        {
            from:"Budgie Schmuggler",
            to:"schmuggles@space.net",
            date:"18/05/2071",
            body:"If you assault one of my ships again I will find you in whatever spacedock you're in and rip out your intestines and feed them to you.\n\nLots of love, Mum\n\nP.S Happy Birthday, I’ve sent you some Holo Cookies xox"
        },
        {
            from:"<UNKNOWN>",
            to:"Captain Schmuggler",
            date:"16/05/2071",
            body:"I didn't want to say this to you in person so I figured doing it anonymously would be best. In the past month our crew has gone down from 5 members including you, to 3 including you and that charming smart Robodrone, and I think with the increased workload you should stop removing the heads of some members and using them for 1 aside football."
        },
        {
            from:"Captain Schmuggler",
            to:"Captain Schmuggler",
            date:"12/05/2071",
            body:"To-do list:\n    Drink\n    Eat\n    Sleep\n    Kick Sodsbury\n    Do pilates\n\n Note to self, to get the ship into warp drive I need to shove something into into the control, I should fix this at the next spacedock."
        }
        ];


        view = MENU;
    }

    function close() {
        FlxG.state.remove(this);
        cast(FlxG.state,Game).canInteract = true;
        if(_shipAttacked == true){
            FlxG.camera.shake (0.01,0.5);
            var game = cast(FlxG.state, Game);
            var player = game.currentRoom.getCharacter("player");
                function _attacked1(){
                cast(game.currentRoom.get("terminal"),Terminal)._warning ();
            }
            function _attacked (){
                player.say("What was that?");
                player.wait(1,_attacked1);
            }
           
            player.wait(1,_attacked);

        }
        destroy();
    }

    function set_view(V:View) {
        textbox.text = "";
        switch(V) {
            case MENU:
                textRem = 'CAPTAIN\'S TERMINAL\n\n'
                    +'(m) view mail [${emails.length} new]\n'
                    +'(c) ship control\n\n'
                    +'(b) close terminal';
                locked = false;
            case EMAILS:
                textRem = "(b) back\n\n";
                textRem += "EMAILS:\n\n";
                var count=1;
                for(e in emails) textRem += '(${count++}) FROM: ${e.from}\n';
            case EMAIL:
                textRem = '(b) back\n\n'
                         + 'DATE: ${emails[email].date}\n'
                         +'FROM: ${emails[email].from}\n'
                         +'TO:${emails[email].to}\n\n'
                         +'${emails[email].body}';
            case PASSWORD:
                textRem = '(b) back\n\nEnter passcode for ventilation system:\n\n  ';
                locked = false;
            case CONTROL:
                textRem = '(b) back\n\nSHIP CONTROL\n\n'
                    + 'Ventilation system status: OFFLINE \n\n'
                    + '(v) activate ventilation system';
                    
            case CONTROL2:
                online = true;
                textRem = '(b) back\n\nSHIP CONTROL\n\n'
                    + 'Ventilation system status: ONLINE \n\n';
                    Game.countdown.stop();
                    _shipAttacked = true;
        }
        return view = V;
    }

    override public function update(d) {
        super.update(d);
        if(textRem != "") {
            textbox.text += textRem.charAt(0);
            textRem = textRem.substr(1);
        }

        switch(view) {
            case MENU:
                if(FlxG.keys.justPressed.M) view = EMAILS;
                else if(FlxG.keys.justPressed.C) view = PASSWORD;
                else if(FlxG.keys.justPressed.B) close();
            case EMAILS:
                if(FlxG.keys.justPressed.B) view = MENU;
                for(i in 0... emails.length)
                    if(FlxG.keys.anyJustPressed([numKeys[i+1],'NUMPAD'+numKeys[i+1]])) {
                    email = i;
                    view = EMAIL;
                }
            case EMAIL:
                if(FlxG.keys.justPressed.B) view = EMAILS;
            case PASSWORD:
                if(!locked) {
                    for(i in 0...10) if(FlxG.keys.anyJustPressed([numKeys[i],'NUMPAD'+numKeys[i]])) {
                        textRem += i;
                        pw += i;
                    }
                    if(FlxG.keys.justPressed.BACKSPACE) {
                        if(pw.length > 0) {
                            textbox.text = textbox.text.substr(0,textRem.length-1);
                            pw = pw.substr(0,pw.length-1);
                        }
                    }
                    else if(FlxG.keys.justPressed.ENTER) {
                        if(pw == "1805") view = online?CONTROL2:CONTROL;
                        else {
                            locked = true;
                            textbox.text = textbox.text.substr(0,textbox.text.lastIndexOf(" "));
                            textRem += "PASSWORD INCORRECT, try again\n";
                        }
                        pw = "";
                    }
                }
                if(FlxG.keys.justPressed.B) view = MENU;
            case CONTROL:
                if(FlxG.keys.justPressed.B) view = MENU;
                if(FlxG.keys.justPressed.V) view = CONTROL2;
            case CONTROL2:
                if(FlxG.keys.justPressed.B) view = MENU;
        }
    }

}

enum View {
    MENU;
    EMAILS;
    EMAIL;
    PASSWORD;
    CONTROL;
    CONTROL2;
}

typedef Email = {
    from:String,
    to:String,
    body:String,
    date:String
}
