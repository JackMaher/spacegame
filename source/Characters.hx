package;

import flixel.FlxG;
using Objects;
using Definitions;

class Player extends Character {
    public var _swing = false;
    public var _canControl = true;

    public function new(x,y):Void {

        super(x, y);

        loadGraphic("assets/images/player.png", true, 14,18);
        animation.add("lr", [0,1,2], 6, false);
        animation.add("idle", [3,4], 3,false);
        animation.add("swing",[5,6,7],3,false);
    }

    private function movement():Void {

        if(!game.canInteract) {
            animation.play("idle");
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

        var moving:Bool = _left || _right;

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
        if (_swing){
            animation.play("swing");
        }
        else if (moving){
            /*_sndStep.play();*/
            animation.play("lr");
        }
        else {
            animation.play("idle");
        }
    }

    override public function update (d){
        super.update(d);
        movement();
    }
}


class Sodsbury extends Character {
    var pickedChip:Bool = false;

    public function new(x,y):Void {
        super (x,y);
        loadGraphic ("assets/images/sodsbury.png", true, 21,16);
        animation.add("walk", [0,1,2,3], 4, true);
        animation.add("deadani",[4,5,6,7,8,9,10],7,false);
        animation.add("dead",[10],0,true);
        animation.play("walk");
        walk1();
        walkSpeed = 2;
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
                say("Good Evening Sir, I'm this Roadmanion Ship personal Robodrone.",null,4);
                say("how may I help you?",null,4);
                wait(4,respond1);
            }
            else if (alive == false && pickedChip == false){
                R.inv.add(new Bionicchip(0,0));
                pickedChip = true;
            }

        }
        function respond1(){
            say("May I asked for you assistance, Captin Schmuggler has left me in disaray.",null,5);
            say("for many years and I'm in need of some maintance can you help?",null,5);
            wait(5, characterRespond);
        }
        function characterRespond(){
            player.option("What Happen to the Crew?",op1);
            player.option("Goodbye");
            endOptions();
        }

    //Dialog #1

        function op1(){
            say("The power genrator failed after a rivial smugger shot at us.",null,4);
            say("it depleated all of the heilum from the ship.",null,4);
            wait(4,op1_1);
        }
        function op1_1(){
            say("The Roadmanion breath a combonation of heilum and oxygen");
            wait(4,op1_2);
        }
        function op1_2(){
            say("if my calulations are right there is around 5 minutes left of");
            say("Oxygen in the ship before its all depleated.");
            wait(3,characterRespond2);
        }

        function characterRespond2(){
            player.option("What Happen to the Crew?",op1);
            player.option("How do I fix the generator?",op2);
            endOptions();
        }

    //Dialog #2

        function op2(){
            say("I would imagine the power genrator room would be best place to start");
            wait (4,op2_1);
        }
        function op2_1(){
            say("If you go back where you came from you will",null,4);
            say("see a rusted manhole leading there",null, 4);
            wait (4,op2_2);
        }
        function op2_2(){
            say("Good luck trying to open it,");
            say(" Captin Schmuggler always had trouble with it.");
            wait(4,op2_3);
        }
        function op2_3(){
            say("and he was a Roadmanion, and youre just a human");
            wait(4,op2_4);
        }
        function  op2_4(){
            say("You'll also need to turn on the air ventulation system once the power is on",null,5);
            say("You can do that at the Captins Terminal, you'll also need the password",null, 5);
            wait(4,characterRespond3);
        }

        function characterRespond3(){
            player.option("What can you tell me about Captin Schmuggler?",op3);
            player.option("How can I help repair you?",op4);
            player.option("Goodbye");
            endOptions();
        }

    //Dialog #3

        function op3(){
            say("Captin Schmuggler was a great man, he salvage me from a ship, that he shot down");
            say("He said that I could be useful to him",null,4) ;
            wait(4,op3_1);
        }
        function op3_1(){
            say("For fun he used to tie me to the front of the ship as a sort of hood ornament",null,4);
            say("and used me for target pratice.",null,4);
            wait(4,op3_2);
        }
        function op3_2(){
            say("He will be missed",null,4);
            wait(4,characterRespond4);
        }
        function characterRespond4(){
            player.option("How can I help repair you?",op4);
            player.option("Goodbye");
            endOptions();
        }


        function op4(){
            say("Last time Captin Schmuggler used me for entertainment he tied me to a");
            say ("spinning wheel and took shots at me, I think one of the bullets is still logded in me");
            wait(3,op4_1);
        }
        function op4_1(){
            say("contrary to popular belief Robodrones can feel pain, and I'm in alot of it",null,5);
            say("if you could find away to remove the bullet I would forever be in your debt.",null,5);
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


