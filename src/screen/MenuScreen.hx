package screen;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.text.Font;
import flash.text.TextField;
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

@:font("Assets/font/Audiowide-Regular.ttf") class AudioWideFont extends Font { }

class MenuScreen extends Screen {
	var startBtn :MenuBtn;
	var testBtn :MenuBtn;
	var lvlSnpSht = new Bitmap();
	var snpShtBmps: Array<BitmapData> = [new C_belugaBitmap(275,186),new C_walrusBitmap(275,186),new C_boatBitmap(275,186),new C_sharkBitmap(275,186),new C_spliffBitmap(275,186),new C_squidBitmap(275,186),new C_clamBitmap(275,186),new C_rustyBitmap(275,186),new C_seagullBitmap(275,186),new C_jellyfishBitmap(275,186)];
	var snpShtLabel: Array<String> = ["Bebop Beluga", "Toothless Walrus", "Rainbow Tanker", "Neurasthenic Shark", "Sea Weed Spliff", "Kinky Squid", "Drunken Clam", "Rusty Tuna Can", "Seven Seagull", "Jealous Jellyfish"];
	var snpShtIndex : Int;
	var constellName:TextField;
	var audioWideFont:Font = new AudioWideFont();
	
	public function new () {
		super();
		snpShtIndex = 0;
		//------------------------
		startBtn = new MenuBtn(Start,startClicked);
		startBtn.x = 300;
		startBtn.y = 350;
		addChild(startBtn);
		//--------------------------
		lvlSnpSht.bitmapData = snpShtBmps[0];
		lvlSnpSht.x = 312;
		lvlSnpSht.y = 120;
		this.addChild(lvlSnpSht);
		//-----------------------------
		constellName = new TextField();
		constellName.width = 400;
		constellName.height = 30;
		constellName.x = 250;
		constellName.y = 306;
		var ssTxtFmt = new TextFormat(audioWideFont.fontName, 25, 0xFFFFFF);
		ssTxtFmt.align = TextFormatAlign.CENTER;
		constellName.defaultTextFormat = ssTxtFmt;
		constellName.text = snpShtLabel[0];
		addChild(constellName);
		//---------------------------------
		KeyboardManager.setCallback(37,leftSnpShtChange);
		KeyboardManager.setCallback(39,rightSnpShtChange);
		KeyboardManager.setCallback(13,startClicked);
	}
	override public function kill ()  {
		super.kill();
		testBtn.kill();
		startBtn.kill();
		for (i in 0...5) {
			snpShtBmps[i].dispose();
		}
		lvlSnpSht = null;
		KeyboardManager.deleteCallback(37);
		KeyboardManager.deleteCallback(39);
	}
	function startClicked() {
		//Man.ins.changeScreen(EScreen.RACER);
		startBtn.kill();
	}
	function leftSnpShtChange() {
		snpShtIndex --;
		if (snpShtIndex < 0) {
			snpShtIndex = 0;
		}else{
			lvlSnpSht.bitmapData = snpShtBmps[snpShtIndex];
			constellName.text = snpShtLabel[snpShtIndex];
		}
	}
	function rightSnpShtChange() {
		snpShtIndex ++;
		if (snpShtIndex > 9) {
			snpShtIndex = 9;
		}else{
			lvlSnpSht.bitmapData = snpShtBmps[snpShtIndex];
			constellName.text = snpShtLabel[snpShtIndex];
		}
	}
}