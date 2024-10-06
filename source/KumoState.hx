package;

import flixel.util.FlxSpriteUtil;
import flixel.util.FlxColor;
import kui.KumoUI;
import flixel.FlxG;
import kui.impl.FlxKumo;
import flixel.FlxState;

class KumoState extends FlxState {
    var UIInterface:FlxKumo;
    override public function create() {
        super.create();
        FlxG.camera.bgColor = FlxColor.GRAY;
        UIInterface = new FlxKumo('', '', FlxG.camera);
        //add(UIInterface.spr);
        add(UIInterface.instances);
    }
    override public function update(elapsed:Float) {
        super.update(elapsed);
        UIInterface.beginDraw();
        UIInterface.begin();
        KumoUI.showDemo();
        UIInterface.end();
    }
}