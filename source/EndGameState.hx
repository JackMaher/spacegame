package;

import flixel.FlxState;
import flixel.FlxSprite;
import flixel.FlxG;

class EndGameState extends FlxState {
	
	override public function create() :Void {
	super.create();
		var died = new FlxSprite(0,0,"assets/images/endgame1.png");
		died.scale.set(Game.SCALE_FACTOR,Game.SCALE_FACTOR);
		add(died);
		died.x = FlxG.width/2-died.width/2;
		died.y = FlxG.height/2-died.height/2;
	}

}