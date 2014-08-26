package screen;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFieldType;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import screen.Screen;
import Man;

/**
 * ...
 * @author 01101101
 */

@:bitmap("assets/img/c_smallBtn/c_squid.png") class C_squidBitmap extends BitmapData {}
@:bitmap("assets/img/c_smallBtn/c_shark.png") class C_sharkBitmap extends BitmapData {}
@:bitmap("assets/img/c_smallBtn/c_spliff.png") class C_spliffBitmap extends BitmapData {}
@:bitmap("assets/img/c_smallBtn/c_beluga.png") class C_belugaBitmap extends BitmapData {}
@:bitmap("assets/img/c_smallBtn/c_boat.png") class C_boatBitmap extends BitmapData {}
@:bitmap("assets/img/c_smallBtn/c_walrus.png") class C_walrusBitmap extends BitmapData { }
@:bitmap("assets/img/c_smallBtn/c_rusty.png") class C_rustyBitmap extends BitmapData { }
@:bitmap("assets/img/c_smallBtn/c_clam.png") class C_clamBitmap extends BitmapData { }
@:bitmap("assets/img/c_smallBtn/c_jellyfish.png") class C_jellyfishBitmap extends BitmapData { }
@:bitmap("assets/img/c_smallBtn/c_seagull.png") class C_seagullBitmap extends BitmapData { }
@:bitmap("assets/img/c_smallBtn/c_otter.png") class C_otterBitmap extends BitmapData { }
@:bitmap("assets/img/c_smallBtn/c_eel.png") class C_eelBitmap extends BitmapData { }

@:bitmap("assets/img/c_smallBtn/c_unknown.png") class C_unknownBitmap extends BitmapData { }

@:bitmap("assets/img/ship_2.png") class ShipBmp extends BitmapData { }

@:font("assets/font/Audiowide-Regular.ttf") class AudioWideFont extends Font { }

class MenuScreen extends Screen {
	var startBtn :MenuBtn;
	var lftBtn :MenuBtn;
	var rghtBtn :MenuBtn;
	var lvlSnpSht = new Bitmap();
	var prevSnpSht = new Bitmap();
	var nextSnpSht = new Bitmap();
	var nextSnpSht2 = new Bitmap();
	var snpShtBmps: Array<BitmapData> = [new C_belugaBitmap(275,186),new C_otterBitmap(275,186),new C_walrusBitmap(275,186),new C_rustyBitmap(275,186),new C_boatBitmap(275,186),new C_seagullBitmap(275,186),new C_eelBitmap(275,186),new C_clamBitmap(275,186),new C_sharkBitmap(275,186),new C_spliffBitmap(275,186),new C_jellyfishBitmap(275,186),new C_squidBitmap(275,186)];
	var snpShtLabel: Array<String> = ["Bebop Beluga", "One-eyed Otter", "Toothless Walrus", "Rusty Tuna Can", "Rainbow Tanker", "Seven Seagull", "Golden Eel", "Drunken Clam", "Neurasthenic Shark", "Sea Weed Spliff", "Jealous Jellyfish", "Kinky Squid"];
	public var discovered :Array<Bool> = [true,true,true,true,true,true,true,true,true,true,true,true];//[false,false,false,false,false,false,false,false,false,false,false,false];
	var snpShtIndex : Int;
	var constellName:TextField;
	var audioWideFont:Font = new AudioWideFont();
	var lvlCounter :TextField;
	
	var pseudoTF:TextField;
	
	public function new () {
		super();
		
		snpShtIndex = 0;
		//------------------------
		startBtn = new MenuBtn(Start,startClicked);
		startBtn.x = 140;
		startBtn.y = 400;
		addChild(startBtn);
		//--------------------------
		lftBtn = new MenuBtn(Left, leftSnpShtChange);
		lftBtn.x = 140;
		lftBtn.y = 490;
		addChild(lftBtn);
		//--------------------------
		rghtBtn = new MenuBtn(Right, rightSnpShtChange);
		rghtBtn.x = 390;
		rghtBtn.y = 490;
		addChild(rghtBtn);
		//--------------------------
		lvlSnpSht.bitmapData = snpShtBmps[0];
		lvlSnpSht.x = 172;
		lvlSnpSht.y = 180;
		this.addChild(lvlSnpSht);
		//-----------------------------
		prevSnpSht.y = 210;
		prevSnpSht.scaleX = 0.8;
		prevSnpSht.scaleY = 0.8;
		prevSnpSht.alpha = 0.2;
		this.addChild(prevSnpSht);
		//-----------------------------
		if (discovered[1]) {
			nextSnpSht.bitmapData = snpShtBmps[1];
		}else {
			nextSnpSht.bitmapData =  new C_unknownBitmap(275,186);
		}
		nextSnpSht.x = 410;
		nextSnpSht.y = 210;
		nextSnpSht.scaleX = 0.8;
		nextSnpSht.scaleY = 0.8;
		nextSnpSht.alpha = 0.2;
		this.addChild(nextSnpSht);
		//-----------------------------
		if (discovered[2]) {
			nextSnpSht2.bitmapData = snpShtBmps[2];
		}else {
			nextSnpSht2.bitmapData =  new C_unknownBitmap(275,186);
		}
		nextSnpSht2.x = 650;
		nextSnpSht2.y = 210;
		nextSnpSht2.scaleX = 0.8;
		nextSnpSht2.scaleY = 0.8;
		nextSnpSht2.alpha = 0.2;
		this.addChild(nextSnpSht2);
		//-----------------------------
		constellName = new TextField();
		constellName.embedFonts = true;
		constellName.selectable = false;
		constellName.width = 400;
		constellName.height = 30;
		constellName.x = 90;
		constellName.y = 356;
		var ssTxtFmt = new TextFormat(audioWideFont.fontName, 25, 0xFFFFFF);
		ssTxtFmt.align = TextFormatAlign.CENTER;
		constellName.defaultTextFormat = ssTxtFmt;
		constellName.text = snpShtLabel[snpShtIndex];
		if(discovered[0]){
			lvlSnpSht.bitmapData = snpShtBmps[snpShtIndex];
		}else {
			lvlSnpSht.bitmapData = new C_unknownBitmap(275,186);
		}
		addChild(constellName);
		//-------------------------------
		lvlCounter = new TextField();
		lvlCounter.embedFonts = true;
		lvlCounter.selectable = false;
		lvlCounter.width =  400;
		lvlCounter.x = 90;
		lvlCounter.y = 500;
		var lcTxtFmt = new TextFormat(audioWideFont.fontName, 15, 0xFFFFFF);
		lcTxtFmt.align = TextFormatAlign.CENTER;
		lvlCounter.defaultTextFormat = lcTxtFmt;
		lvlCounter.text = "Constellation "+(snpShtIndex + 1) + "/12";
		addChild(lvlCounter);
		//---------------------------------
		var openPod = new Bitmap();
		openPod.bitmapData = new ShipBmp(446,522);
		openPod.x = 450;
		openPod.y = 120;
		openPod.scaleX = 0.8;
		openPod.scaleY = 0.8;
		addChild(openPod);
		//
		
		pseudoTF = new TextField();
		pseudoTF.type = TextFieldType.INPUT;
		pseudoTF.background = true;
		pseudoTF.backgroundColor = 0x666666;
		var format = new TextFormat("Arial", 32, 0xFFFFFF);
		format.align = TextFormatAlign.CENTER;
		pseudoTF.defaultTextFormat = format;
		pseudoTF.width = 400;
		pseudoTF.height = 45;
		pseudoTF.text = Main.pseudo;
		pseudoTF.x = (Const.STAGE_WIDTH - pseudoTF.width) / 2;
		pseudoTF.y = 30;
		pseudoTF.restrict = "a-z A-Z 0-9";
		addChild(pseudoTF);
		
		//-------------------------------------
		KeyboardManager.setCallback(37,leftSnpShtChange);
		KeyboardManager.setCallback(39,rightSnpShtChange);
		KeyboardManager.setCallback(13,startClicked);
	}
	
	override public function kill ()  {
		super.kill();
		startBtn.kill();
		lftBtn.kill();
		rghtBtn.kill();
		snpShtIndex = 0;
		for (i in 0...5) {
			snpShtBmps[i].dispose();
		}
		lvlSnpSht = null;
		KeyboardManager.deleteCallback(37);
		KeyboardManager.deleteCallback(39);
		KeyboardManager.deleteCallback(13);
	}
	
	function startClicked() {
		Main.pseudo = pseudoTF.text;
		SoundMan.ins.playSFX("click");
		switch (snpShtIndex) {
			case 0:		Man.ins.changeScreen(EScreen.RACER_BELUGA);
			case 1:		Man.ins.changeScreen(EScreen.RACER_OTTER);
			case 2:		Man.ins.changeScreen(EScreen.RACER_WALRUS);
			case 3:		Man.ins.changeScreen(EScreen.RACER_RUSTY);
			case 4:		Man.ins.changeScreen(EScreen.RACER_BOAT);
			case 5:		Man.ins.changeScreen(EScreen.RACER_SEAGULL);
			case 6:		Man.ins.changeScreen(EScreen.RACER_EEL);
			case 7:		Man.ins.changeScreen(EScreen.RACER_CLAM);
			case 8:		Man.ins.changeScreen(EScreen.RACER_SHARK);
			case 9:		Man.ins.changeScreen(EScreen.RACER_SPLIFF);
			case 10:	Man.ins.changeScreen(EScreen.RACER_JELLYFISH);
			case 11:	Man.ins.changeScreen(EScreen.RACER_SQUID);
		}
	}
	
	function leftSnpShtChange() {
		SoundMan.ins.playSFX("click");
		snpShtIndex --;
		if (snpShtIndex < 0) {
			snpShtIndex = 0;
		}else{
			constellName.text = snpShtLabel[snpShtIndex];
			lvlCounter.text = "Constellation "+(snpShtIndex + 1) + "/12";
			if(discovered[snpShtIndex]){
				updatePrev();
				updateNext();
				updateNext2();
				lvlSnpSht.bitmapData = snpShtBmps[snpShtIndex];
			}else {
				updatePrev();
				updateNext();
				updateNext2();
				lvlSnpSht.bitmapData = new C_unknownBitmap(275,186);
			}
		}
	}
	function rightSnpShtChange() {
		SoundMan.ins.playSFX("click");
		snpShtIndex ++;
		if (snpShtIndex > snpShtBmps.length-1) {
			snpShtIndex = snpShtBmps.length-1;
		}else{
			constellName.text = snpShtLabel[snpShtIndex];
			lvlCounter.text = "Constellation "+(snpShtIndex + 1) + "/12";
			if(discovered[snpShtIndex]){
				updatePrev();
				updateNext();
				updateNext2();
				lvlSnpSht.bitmapData = snpShtBmps[snpShtIndex];
			}else {
				updatePrev();
				updateNext();
				updateNext2();
				lvlSnpSht.bitmapData = new C_unknownBitmap(275, 186);
			}
		}
	}
	function updateNext () {
		if (discovered[snpShtIndex + 1]) {
			nextSnpSht.bitmapData = snpShtBmps[snpShtIndex + 1];
		}else {
			if (snpShtIndex + 1 > 0 && snpShtIndex + 1 < 11) {
				nextSnpSht.bitmapData = new C_unknownBitmap(275,186);
			}else {
				nextSnpSht.bitmapData = null;
			}
		}
	}
	function updateNext2 () {
		if (discovered[snpShtIndex + 2]) {
			nextSnpSht2.bitmapData = snpShtBmps[snpShtIndex + 2];
		}else {
			if (snpShtIndex + 2 > 0 && snpShtIndex + 2 < 11) {
				nextSnpSht2.bitmapData = new C_unknownBitmap(275,186);
			}else {
				nextSnpSht2.bitmapData = null;
			}
		}
	}
	function updatePrev () {
		if (discovered[snpShtIndex - 1]) {
			prevSnpSht.bitmapData = snpShtBmps[snpShtIndex - 1];
		}else {
			if (snpShtIndex - 1 > 0 && snpShtIndex - 1 < 11) {
				prevSnpSht.bitmapData = new C_unknownBitmap(275,186);
			}else {
				prevSnpSht.bitmapData = null;
			}
		}
	}
}