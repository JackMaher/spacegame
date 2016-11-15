package;

import flixel.FlxG;
import flixel.util.FlxColor;
using Objects;
using Definitions;
using Game;

class Player extends Character {
    public var _swing = false;
    public var _canControl = true;
    public var _dead = false;
    public var _moving = false;
    public var _screw = false;

    public function new(x,y):Void {

        super(x, y);

        loadGraphic("assets/images/player.png", true, 14,18);
        animation.add("lr", [0,1,2], 6, false);
        animation.add("idle", [3,4], 3,false);
        animation.add("swing",[5,6,7],3,false);
        animation.add("dead",[8,9,10,11,12,13,14],7,false);
        animation.add("screw",[15,16,17],3,false);
    }

    private function movement():Void {

        if(!game.canInteract) {
            //animation.play("idle");
            return;
        }

        var _left  = false;
        var _right = false;

        if(walk != null) {
            if(x > walk.pos) _left = true;
            if(x < walk.pos) _right = true;
        }
        else if (_canControl) {
            if(flixel.FlxG.keys.anyPressed(["LEFT","A"])) _left = true;
            if(flixel.FlxG.keys.anyPressed(["RIGHT","D"])) _right = true;
        }

        _moving = _left || _right;

        if (_left && _right)
            _left = _right = false;


        if (_left){
            if(walk==null) x -= walkSpeed;
            flipX = true;
        }
        else if (_right){
            if(walk==null) x += walkSpeed;
            flipX = false;
        }

    }

    override public function update (d){
        super.update(d);
        movement();
        if (_swing){
            animation.play("swing");
        }
        else if(_dead){
        
        }
        else if (_moving){
            /*_sndStep.play();*/
            animation.play("lr");
        }
        else if (_screw){
            animation.play("screw");
        }
        else {
            animation.play("idle");
        }

        if(Countdown.done && _dead == false){
            _die();
        }

    }


    function _die(){
            _dead = true;
            animation.play("dead");
            game.canInteract = false;
            var df = new Deadfadeout(0,0);
            currentRoom.objects.push(df);
            df.x = FlxG.width/2-df.width/2;
            df.y = Game.ROOM_HEIGHT/2-df.height/2+Game.ROOM_TOP;
    }
       public function ending1(){
            game.canInteract = false;
            var df = new Deadfadeout(0,0);
            currentRoom.objects.push(df);
            df.x = FlxG.width/2-df.width/2;
            df.y = Game.ROOM_HEIGHT/2-df.height/2+Game.ROOM_TOP;
    }
}
class Sodsbury extends Character {
    var pickedChip:Bool = false;
    var startedChat:Bool = false;

    override public function isCursorOverPixels():Bool {
        return overlapsPoint(FlxG.mouse.getPosition());
    }

    public function new(x,y):Void {
        super (x,y);
        loadGraphic ("assets/images/sodsbury.png", true, 21,16);
        animation.add("walk", [0,1,2,3], 4, true);
        animation.add("deadani",[4,5,6,7,8,9,10],7,false);
        animation.add("dead",[10],0,true);
        animation.play("walk");
        walk1();
        walkSpeed = 2;
        customName = "Sodsbury";
    }


        public override function update(d){
            super.update(d);
            if (walk != null) flipX = x < walk.pos;
        }

        function walk1(){
            walkTo(90,walk2);
        }
            function walk2(){
            walkTo(50,walk1);
        }



        public function use(){
            walk = null;
            if (alive){
                if(startedChat == false) {
                startedChat = true;
                say("Good Evening Sir, I'm this Roadmanion ship’s personal Robodrone.",FlxColor.ORANGE,4);
                say("how may I help you?",FlxColor.ORANGE,4);
                wait(4,respond1);
                }
            }
            else if (alive == false && pickedChip == false){
                R.inv.add(new Bionicchip(0,0));
                pickedChip = true;
                player.say("This might be useful");
            }
            else if (pickedChip == true){
                player.say("Goodnight sweet prince");
            }

        }
        function respond1(){
            say("May I ask for you assistance? Captain Schmuggler has left me in disarray.",FlxColor.ORANGE,5);
            say("for many years and I'm in need of some maintenance; can you help?",FlxColor.ORANGE,5);
            wait(5, characterRespond);
        }
        function canUse() {
            startedChat = false;
        }
        function characterRespond(){
            player.option("What Happened to the Crew?",op1);
            player.option("Goodbye", canUse);
            endOptions();
        }


    //Dialog #1
        function op1() {
            wait(3,op1_wait);
        }
        function op1_wait(){
            say("The power generator failed after a rival smuggler shot at us.",FlxColor.ORANGE,4);
            say("it depleted all of the helium from the ship.",FlxColor.ORANGE,4);
            wait(4,op1_1);
        }
        function op1_1(){
            say("The Roadmanion breathe a combination of helium and oxygen",FlxColor.ORANGE,4);
            wait(4,op1_2);
        }
        function op1_2(){
            say("if my calculations are right there is around 5 minutes left of",FlxColor.ORANGE,5);
            say("Oxygen in the ship before it's all depleted.",FlxColor.ORANGE,5);
            wait(5,characterRespond2);
        }

        function characterRespond2(){
            player.option("What Happened to the Crew?",op1);
            player.option("How do I fix the generator?",op2);
            endOptions();
        }

    //Dialog #2

        function op2() {
            wait(3,op2_wait);
        }
        function op2_wait(){
            say("I would imagine the power generator room would be best place to start",FlxColor.ORANGE);
            wait (4,op2_1);
        }
        function op2_1(){
            say("If you go back where you came from you will",FlxColor.ORANGE,4);
            say("see a rusted manhole leading there",FlxColor.ORANGE, 4);
            wait (4,op2_2);
        }
        function op2_2(){
            say("Good luck trying to open it,",FlxColor.ORANGE);
            say(" Captain Schmuggler always had trouble with it.",FlxColor.ORANGE);
            wait(4,op2_3);
        }
        function op2_3(){
            say("and he was a Roadmanion, and you're just a human",FlxColor.ORANGE);
            wait(4,op2_4);
        }
        function  op2_4(){
            say("You'll also need to turn on the air ventilation system once the power is on",FlxColor.ORANGE,5);
            say("You can do that at the Captain's Terminal, you'll also need the password",FlxColor.ORANGE, 5);
            wait(4,characterRespond3);
        }

        function characterRespond3(){
            player.option("What can you tell me about Captain Schmuggler?",op3);
            player.option("How can I help repair you?",op4);
            player.option("Goodbye");
            endOptions();
        }

    //Dialog #3

        function op3() {
            wait(3,op3_wait);
        }
        function op3_wait(){
            say("Captain Schmuggler was a great man, he salvaged me from a ship, that he shot down",FlxColor.ORANGE);
            say("He said that I could be useful to him",FlxColor.ORANGE,4) ;
            wait(4,op3_1);
        }
        function op3_1(){
            say("For fun he used to tie me to the front of the ship as a sort of hood ornament",FlxColor.ORANGE,4);
            say("and used me for target pratice.",FlxColor.ORANGE,4);
            wait(4,op3_2);
        }
        function op3_2(){
            say("He will be missed",FlxColor.ORANGE,4);
            wait(4,characterRespond4);
        }
        function characterRespond4(){
            player.option("How can I help repair you?",op4);
            player.option("Goodbye");
            endOptions();
        }


        function op4() {
            wait(3,op4_wait);
        }
        function op4_wait(){
            say("Last time Captain Schmuggler used me for entertainment he tied me to a",FlxColor.ORANGE);
            say ("spinning wheel and took shots at me, I think one of the bullets is still lodged in me",FlxColor.ORANGE);
            wait(3,op4_1);
        }
        function op4_1(){
            say("contrary to popular belief Robodrones can feel pain, and I'm in a lot of it",FlxColor.ORANGE,5);
            say("if you could find away to remove the bullet I would forever be in your debt.",FlxColor.ORANGE,5);
            wait(3,characterRespond5);
        }

        function characterRespond5(){
            player.option("How do I fix the generator again?",op2);
            player.option("How can I help repair you?",op4);
            player.option("Goodbye");
            endOptions();
        }

        override function kill(){
            animation.play("deadani");
            alive = false;
            wait (1,die);
        }
        override function die(){
            animation.play("dead");
            super.die();
        }

    }


