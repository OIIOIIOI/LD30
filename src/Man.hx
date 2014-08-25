package ;

import flash.Lib;
import racer.Racer;
import screen.MenuScreen;
import screen.Screen;
import screen.TitleScreen;
import shooter.Shooter;

/**
 * ...
 * @author 01101101
 */

class Man {
	
	public static var ins:Man;
	
	var curEScr:EScreen;
	var curScr:Screen;
	
	public function new () {
		if (Man.ins != null)	return;
		
		Man.ins = this;
	}
	
	public function changeScreen (e:EScreen) {
		// Kill current screen
		if (curScr != null) {
			//trace("KILL " + curEScr);
			if (Lib.current.stage.contains(curScr))	Lib.current.stage.removeChild(curScr);
			curScr.kill();
			curScr = null;
		}
		// Set up new screen
		//trace("CREATE " + e);
		curScr = switch (e) {
			case EScreen.TITLE:				new TitleScreen();
			case EScreen.MENU:				new MenuScreen();
			case EScreen.RACER_BELUGA:		new Racer(ELevel.LBeluga);
			case EScreen.RACER_BOAT:		new Racer(ELevel.LBoat);
			case EScreen.RACER_CLAM:		new Racer(ELevel.LClam);
			case EScreen.RACER_EEL:			new Racer(ELevel.LEel);
			case EScreen.RACER_JELLYFISH:	new Racer(ELevel.LJellyfish);
			case EScreen.RACER_OTTER:		new Racer(ELevel.LOtter);
			case EScreen.RACER_RUSTY:		new Racer(ELevel.LRusty);
			case EScreen.RACER_SEAGULL:		new Racer(ELevel.LSeagull);
			case EScreen.RACER_SHARK:		new Racer(ELevel.LShark);
			case EScreen.RACER_SPLIFF:		new Racer(ELevel.LSpliff);
			case EScreen.RACER_SQUID:		new Racer(ELevel.LSquid);
			case EScreen.RACER_WALRUS:		new Racer(ELevel.LWalrus);
		}
		Lib.current.stage.addChild(curScr);
		curEScr = e;
	}
	
	public function update () {
		if (curScr != null) {
			curScr.update();
		}
	}
	
}

enum EScreen {
	TITLE;
	MENU;
	RACER_BELUGA;
	RACER_BOAT;
	RACER_CLAM;
	RACER_EEL;
	RACER_JELLYFISH;
	RACER_OTTER;
	RACER_RUSTY;
	RACER_SEAGULL;
	RACER_SHARK;
	RACER_SPLIFF;
	RACER_SQUID;
	RACER_WALRUS;
}
