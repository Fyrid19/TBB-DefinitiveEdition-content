function onLoad() {
    var vingette = new FlxSprite().loadGraphic(Paths.image("vig"));
    vingette.setGraphicSize(FlxG.width, FlxG.height);
    vingette.screenCenter();
    vingette.alpha = 0.4;
    vingette.cameras = [camHUD];
    add(vingette);
}