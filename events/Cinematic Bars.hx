var barTop:FlxSprite;
var barBottom:FlxSprite;

function onLoad() {
    barTop = new FlxSprite().makeGraphic(FlxG.width, FlxG.height/2, FlxColor.BLACK);
    barTop.cameras = [camHUD];
    barTop.y = -barTop.height;
    insert(0, barTop);

    barBottom = new FlxSprite().makeGraphic(FlxG.width, FlxG.height/2, FlxColor.BLACK);
    barBottom.cameras = [camHUD];
    barBottom.y = FlxG.height;
    insert(0, barBottom);
}

function onEvent(n:String, v1:String, v2:String) {
    if (n == 'Cinematic Bars') {
        var amount = Std.parseInt(v1);

        var vals = v2.split(',');
        var duration = vals[0] ? Std.parseFloat(vals[0]) : 1;
        var ease = stringToEase(vals[1]);
        var hideNotes = vals[2] ?? 'true';

        // moves the BARS
        FlxTween.tween(barTop, { y: -barTop.height + amount }, duration, { ease: ease });
        FlxTween.tween(barBottom, { y: FlxG.height - amount }, duration, { ease: ease });

        // hide hud elements
        for (member in playHUD.members) {
            if (member != null && Std.is(member, FlxSprite) && member != barTop && member != barBottom) {
                FlxTween.tween(member, { alpha: (amount > 0) ? 0 : 1 }, duration, { ease: ease });
            }
        }

        // hides the strums
        for (field in playFields.members) if (field != null) {
            field.forEachAlive((note) -> {
                note.y -= amount;
                if (hideNotes == 'true' || hideNotes == '')
                    FlxTween.tween(note, { alpha: (amount > 0) ? 0 : 1 }, duration, { ease: ease });
                else
                    FlxTween.tween(note, { alpha: 1 }, duration, { ease: ease });
            });
        }

        // one catch about this is that i don't think it hides notes that are about to spawn, tho i don't think anyone would use it in the middle of a section anyway
        if (hideNotes == 'true' || hideNotes == '') {
            for (note in notes.members) {
                if (note != null) {
                    FlxTween.tween(note, { alpha: (amount > 0) ? 0 : 1 }, duration, { ease: ease });
                }
            }
        } else {
            for (note in notes.members) {
                if (note != null) {
                    FlxTween.tween(note, { alpha: 1 }, duration, { ease: ease });
                }
            }
        }
    }
}

function stringToEase(easeName:String):FlxEase {
    return switch (easeName) {
        case 'quadIn':
            FlxEase.quadIn;
        case 'quadOut':
            FlxEase.quadOut;
        case 'quadInOut':
            FlxEase.quadInOut;
        
        case 'cubicIn':
            FlxEase.cubicIn;
        case 'cubicOut':
            FlxEase.cubicOut;
        case 'cubicInOut':
            FlxEase.cubicInOut;
        
        case 'quartIn':
            FlxEase.quartIn;
        case 'quartOut':
            FlxEase.quartOut;
        case 'quartInOut':
            FlxEase.quartInOut;
        
        case 'quintIn':
            FlxEase.quintIn;
        case 'quintOut':
            FlxEase.quintOut;
        case 'quintInOut':
            FlxEase.quintInOut;
        
        case 'sineIn':
            FlxEase.sineIn;
        case 'sineOut':
            FlxEase.sineOut;
        case 'sineInOut':
            FlxEase.sineInOut;
        
        case 'expoIn':
            FlxEase.expoIn;
        case 'expoOut':
            FlxEase.expoOut;
        case 'expoInOut':
            FlxEase.expoInOut;
        
        case 'circIn':
            FlxEase.circIn;
        case 'circOut':
            FlxEase.circOut;
        case 'circInOut':
            FlxEase.circInOut;
        
        default:
            FlxEase.linear;
    }
}