var elapsedtime:Float = 0;
function onUpdate(elapsed:Float) {
    elapsedtime += elapsed;
    game.dad.x += (Math.cos(elapsedtime) * 0.6);
    game.dad.y += (Math.sin(elapsedtime) * 0.6);
}