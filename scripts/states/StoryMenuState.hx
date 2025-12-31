var bg:FlxSprite;
var curSelected:Int;

var weekColors:Array<FlxColor> = [
    0x03CE2F,
    0x911EEE,
    0x2455DB,
    0xFFCE47
];

function onLoad() {
    bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
    bg.color = weekColors[curSelected];
    bg.setGraphicSize(Std.int(bg.width * 1.1));
    bg.screenCenter();
    add(bg);
}