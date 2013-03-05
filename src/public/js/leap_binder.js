var curGesutre = 0;

Leap.loop({enableGestures : true}, function(frame) {
  if (frame.gestures && frame.gestures.length > 0) {
    var gestureList = frame.gestures;
    for (var gestureIdx = 0; gestureIdx < gestureList.length; gestureIdx++) {
      var gesture = gestureList[gestureIdx];
      if (gesture.type == 'swipe') {
        var directions = gesture.direction;
        var xVal = Math.abs(directions[0]);
        var yVal = Math.abs(directions[1]);
        if(xVal > yVal) { // only work for horizontal swipe
          if (directions[0] > 0) {
            curGesutre = 1; // 1 for right
          } else {
            curGesutre = -1; // -1 for left
          }
        }
      }
    }
  }
});

function swipePage() {
  if (curGesutre > 0) {
    nextPage();
  } else if(curGesutre < 0) {
    prevPage();
  }

  curGesutre = 0;
}

setInterval(swipePage, 1000);
