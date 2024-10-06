package kui.impl;

import flixel.text.FlxText;
import lime.system.Clipboard;
import flixel.math.FlxPoint;
import flixel.FlxObject;
import flixel.group.FlxGroup;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.input.keyboard.FlxKey;
import flixel.FlxSprite;
import flixel.util.FlxSpriteUtil;

class FlxKumo extends Base {

    //public var spr:FlxSprite;
    public var instances:FlxTypedGroup<FlxObject>;
    public var target_cam:FlxCamera;

    public var font_regular:String;
    public var font_bold:String;

    private var keyMap: Map<FlxKey, kui.Key> = [
        // Letters
        A => KEY_A,
        B => KEY_B,
        C => KEY_C,
        D => KEY_D,
        E => KEY_E,
        F => KEY_F,
        G => KEY_G,
        H => KEY_H,
        I => KEY_I,
        J => KEY_J,
        K => KEY_K,
        L => KEY_L,
        M => KEY_M,
        N => KEY_N,
        O => KEY_O,
        P => KEY_P,
        Q => KEY_Q,
        R => KEY_R,
        S => KEY_S,
        T => KEY_T,
        U => KEY_U,
        V => KEY_V,
        W => KEY_W,
        X => KEY_X,
        Y => KEY_Y,
        Z => KEY_Z,
    
        // Numbers
        ONE => KEY_1,
        TWO => KEY_2,
        THREE => KEY_3,
        FOUR => KEY_4,
        FIVE => KEY_5,
        SIX => KEY_6,
        SEVEN => KEY_7,
        EIGHT => KEY_8,
        NINE => KEY_9,
        ZERO => KEY_0,
    
        // Symbols (if needed you can add more)
        MINUS => KEY_MINUS,
        PLUS => KEY_EQUALS,
        LBRACKET => KEY_OPEN_BRACKET,
        RBRACKET => KEY_CLOSE_BRACKET,
        BACKSLASH => KEY_BACKSLASH,
        SEMICOLON => KEY_SEMICOLON,
        QUOTE => KEY_SINGLE_QUOTE,
        GRAVEACCENT => KEY_GRAVE,
        COMMA => KEY_COMMA,
        PERIOD => KEY_PERIOD,
        SLASH => KEY_SLASH,
    
        // Special keys
        ESCAPE => KEY_ESCAPE,
        SPACE => KEY_SPACE,
        ENTER => KEY_ENTER,
        TAB => KEY_TAB,
        BACKSPACE => KEY_BACKSPACE,
        LEFT => KEY_LEFT,
        RIGHT => KEY_RIGHT,
        UP => KEY_UP,
        DOWN => KEY_DOWN,
        END => KEY_END,
        HOME => KEY_HOME,
    ];
    

    public function new(regularFont:String, boldFont:String, ?targetCam:FlxCamera) {
        super();

        this.font_regular = regularFont;
        this.font_bold = boldFont;
        this.target_cam = targetCam;

        instances = new FlxTypedGroup<FlxObject>();
        //spr = new FlxSprite(0, 0);
        //spr.makeGraphic(targetCam.width, targetCam.height, FlxColor.TRANSPARENT);
        //spr.camera = targetCam;
        
        KumoUI.init(this, false);
    }

    // Input
    override public function getMouseX(): Float return FlxG.mouse.getScreenPosition(target_cam).x;
    override public function getMouseY(): Float return FlxG.mouse.getScreenPosition(target_cam).y;
    override public function getLeftMouseDown(): Bool return FlxG.mouse.pressed;
    override public function getRightMouseDown(): Bool return FlxG.mouse.pressedRight;
    override public function getScrollDelta():Float return FlxG.mouse.wheel * 50;

    // Drawing Internals
    override public function beginDraw(): Void {
        instances.forEachAlive((i:FlxObject) -> {
            i.destroy();
            i = null;
        });
        instances.clear();
    }
    override public function endDraw(): Void {}
    override public function getDeltaTime(): Float return 1 / FlxG.updateFramerate;

    // Drawing
    override public function drawRect(x: Float, y: Float, width: Float, height: Float, color: Int, roundness: Float = 0): Void {
        var obj = new FlxSprite(0, 0);
        obj.makeGraphic(target_cam.width, target_cam.height, FlxColor.TRANSPARENT);
        obj.camera = target_cam;
        instances.add(obj);
        if (roundness > 0)
            FlxSpriteUtil.drawRoundRect(obj, x, y, width, height, roundness, roundness, FlxColor.fromInt(color));
        else
            FlxSpriteUtil.drawRect(obj, x, y, width, height, FlxColor.fromInt(color));
    }

    override function drawRectOutline(x:Float, y:Float, width:Float, height:Float, color:Int, thickness:Float = 1, roundness:Float = 0) {
        var obj = new FlxSprite(0, 0);
        obj.makeGraphic(target_cam.width, target_cam.height, FlxColor.TRANSPARENT);
        obj.camera = target_cam;
        instances.add(obj);
        if (roundness > 0){
            FlxSpriteUtil.drawRoundRect(obj, x, y, width, height, roundness, roundness, FlxColor.TRANSPARENT, {
                thickness: thickness,
                color: FlxColor.fromInt(color)
            });
        }else{
            FlxSpriteUtil.drawRect(obj, x, y, width, height, FlxColor.TRANSPARENT, {
                thickness: thickness,
                color: FlxColor.fromInt(color)
            });
        }
    }

    // I have to find a better way to do this, this is attrocious
    override public function drawText(text: String, x: Float, y: Float, color: Int, size: Int = 16, font: FontType = FontType.REGULAR): Void {
        var txt:FlxText = new FlxText(x, y, 0, text, size);
        txt.color = color;
        txt.font = font == FontType.REGULAR ? font_regular : font_bold;
        instances.add(txt);
    }

    // I hope this is accurate enough
    override public function measureTextWidth(text: String, size: Int = 16, font: FontType = FontType.REGULAR): Float {
        var txt:FlxText = new FlxText(0, 0, 0, text, size);
        txt.font = font == FontType.REGULAR ? font_regular : font_bold;
        return txt.fieldWidth;
    }

    override public function drawLine(x1: Float, y1: Float, x2: Float, y2: Float, color: Int, thickness: Float = 1): Void {
        var obj = new FlxSprite(0, 0);
        obj.makeGraphic(target_cam.width, target_cam.height, FlxColor.TRANSPARENT);
        obj.camera = target_cam;
        instances.add(obj);
        FlxSpriteUtil.drawLine(obj, x1, y1, x2, y2, {
            thickness: thickness,
            color: FlxColor.fromInt(color)
        });
    }

    override public function setClipRect(x: Float, y: Float, width: Float, height: Float): Void {
        //spr.clipRect = new FlxRect(x, y, width, height);
        //spr.clipRect = spr.clipRect; // Why do I have to reassign it, this is dumb ngl
    }

    override function drawTriangle(cx:Float, cy:Float, len: Float, rotation:Float, color:Int) {
        var height = Math.sqrt(3) / 2 * len;
        var triSpr:FlxSprite = new FlxSprite(0, 0);
        triSpr.makeGraphic(target_cam.width, target_cam.height, FlxColor.TRANSPARENT);
        FlxSpriteUtil.drawTriangle(triSpr, cx, cy, height, FlxColor.fromInt(color));
        triSpr.angle = rotation;
        instances.add(triSpr);
    }

    override function drawTrianglePoints(x1:Float, y1:Float, x2:Float, y2:Float, x3:Float, y3:Float, color:Int) {
        var obj = new FlxSprite(0, 0);
        obj.makeGraphic(target_cam.width, target_cam.height, FlxColor.TRANSPARENT);
        obj.camera = target_cam;
        instances.add(obj);
        FlxSpriteUtil.drawPolygon(obj, [new FlxPoint(x1, y1), new FlxPoint(x2, y2), new FlxPoint(x3, y3)], FlxColor.fromInt(color));
    }

    override public function drawCircle(cx: Float, cy: Float, radius: Float, color: Int): Void {
        var obj = new FlxSprite(0, 0);
        obj.makeGraphic(target_cam.width, target_cam.height, FlxColor.TRANSPARENT);
        obj.camera = target_cam;
        instances.add(obj);
        FlxSpriteUtil.drawCircle(obj, cx, cy, radius, FlxColor.fromInt(color));
    }

    override public function resetClipRect(): Void {
        //spr.clipRect = null;
        //spr.clipRect = spr.clipRect; // aaagh make it end!!!
    }
    
    override public function setClipboard(text: String): Void Clipboard.text = text;
    override public function getClipboard(): String return Clipboard.text;

    // Flixel-specific
    public function begin() {
        KumoUI.begin(FlxG.width, FlxG.height);

        KeyboardInput.setCurrentShiftMod(FlxG.keys.pressed.SHIFT);
        KeyboardInput.setCurrentCapsMod(FlxG.keys.pressed.CAPSLOCK);
        if (FlxG.keys.pressed.CONTROL) KeyboardInput.reportKey(KEY_CTRL);
        KeyboardInput.reportKey(keyMap.get(FlxG.keys.firstJustPressed()));
        KeyboardInput.submit();
    }
    public function end() {
        KumoUI.render();
    }

}