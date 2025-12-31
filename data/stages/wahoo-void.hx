var stagePrefix = 'stages/wahoo-void/';

var preloadAssets = [
    'waoo-threedee-stage-2d',
    'waoo-threedee-stage-old',
    'waoo-threedee-stage-ew',
    'waoo-threedee-stage-invert',
    'wahoo-world-ground-2d',
    'wahoo-world-ground-old',
    'wahoo-world-ground-ew',
    'wahoo-world-ground-invert'
];

var loadedAssets:Array<Array<Dynamic>> = [];

var curVariant:String = '';

var ethanPos:FlxPoint = new FlxPoint(-200, 500);
var rPos:FlxPoint = new FlxPoint(400, 400);
var bandoPos:FlxPoint = new FlxPoint(1200, 450);

var ethanScale:Float = 0.7;
var rScale:Float = 0.7;
var bandoScale:Float = 0.7;

var shader = null;
function onCreatePost() {
    shader = newShader('glitchShader');
    shader.setFloat('uSpeed', 2);
    shader.setFloat('uWaveAmplitude', 0.2);
    shader.setFloat('uFrequency', 5);
    shader.setBool('uEnabled', true);

    background.shader = shader;

    for (i in 0...preloadAssets.length) {
        var assetName = preloadAssets[i];
        var assetPath = stagePrefix + assetName;
        loadedAssets[i] = [assetName, Paths.image(assetPath)];
    }

    ethan.frames = Paths.getMultiAtlas(['stages/ethan-halp', 'stages/ethan-wethan', 'stages/funny-guys']);
    r.frames = Paths.getMultiAtlas(['stages/r', 'stages/r-peak', 'stages/bando-r-uh', 'stages/funny-guys']);
    bando.frames = Paths.getMultiAtlas(['stages/bando', 'stages/bando-peak', 'stages/bando-r-uh', 'stages/funny-guys']);

    ethan.animation.addByPrefix('idle', 'idleUhOh', 24, false);
    ethan.animation.addByPrefix('idle-2d', 'idle3d', 24, false);
    ethan.animation.addByPrefix('idle-old', 'idleEthan', 24, false);
    ethan.animation.addByPrefix('idle-ew', 'idleEw', 24, false);
    
    r.animation.addByPrefix('idle', 'what', 24, false);
    r.animation.addByPrefix('idle-2d', 'idleR2d', 24, false);
    r.animation.addByPrefix('idle-old', 'idleMare', 24, false);
    r.animation.addByPrefix('idle-ew', 'idlePeak', 24, false);
    
    bando.animation.addByPrefix('idle', 'what', 24, false);
    bando.animation.addByPrefix('idle-2d', 'idleBando2d', 24, false);
    bando.animation.addByPrefix('idle-old', 'idleBando', 24, false);
    bando.animation.addByPrefix('idle-ew', 'idlePeak', 24, false);

    ethan.animation.play('idle', true);
    r.animation.play('idle', true);
    bando.animation.play('idle', true);

    ethan.x = ethanPos.x;
    ethan.y = ethanPos.y;
    r.x = rPos.x;
    r.y = rPos.y;
    bando.x = bandoPos.x;
    bando.y = bandoPos.y;

    ethan.setGraphicSize(Std.int(ethan.width * ethanScale));
    r.setGraphicSize(Std.int(r.width * rScale));
    bando.setGraphicSize(Std.int(bando.width * bandoScale));
}

function onBeatHit() {
    if (curBeat % 2 == 0) {
        if (curVariant != '-invert') {
            ethan.animation.play('idle' + curVariant, true);
            r.animation.play('idle' + curVariant, true);
            bando.animation.play('idle' + curVariant, true);
        } else {
            ethan.animation.play('idle', true);
            r.animation.play('idle', true);
            bando.animation.play('idle', true);
        }
    }
}

var elapsedtime:Float = 0;
function onUpdate(elapsed:Float) {
    elapsedtime += elapsed;
    shader.setFloat('uTime', elapsedtime);

    var angle = 10;

    ethan.angle = Math.sin(elapsedtime) * angle;
    r.angle = Math.sin(elapsedtime) * angle;
    bando.angle = Math.sin(elapsedtime) * angle;

    ethan.x += (Math.cos(elapsedtime) * 0.2);
    ethan.y += (Math.sin(elapsedtime) * 1.2);
    r.x -= (Math.cos(elapsedtime) * 0.2);
    r.y -= (Math.sin(elapsedtime) * 1.2);
    bando.x += (Math.cos(elapsedtime) * 0.2);
    bando.y += (Math.sin(elapsedtime) * 0.9);
}

function getAsset(name:String):FlxGraphic {
    for (asset in loadedAssets) {
        if (asset[0] == name) {
            return asset[1];
        }
    }
    return null;
}

function onEvent(n:String, v1:String, v2:String) {
    if (n == 'wahoovoidswitch') {
        var bgAssetName = 'waoo-threedee-stage-' + v1;
        var platformAssetName = 'wahoo-world-ground-' + v1;

        curVariant = '-' + v1;

        var bgGraphic = getAsset(bgAssetName);
        var platformGraphic = getAsset(platformAssetName);

        if (bgGraphic != null) {
            background.loadGraphic(bgGraphic);
        }

        if (platformGraphic != null) {
            platform.loadGraphic(platformGraphic);
        }

        ethan.x = ethanPos.x;
        ethan.y = ethanPos.y;
        r.x = rPos.x;
        r.y = rPos.y;
        bando.x = bandoPos.x;
        bando.y = bandoPos.y;
    }
}