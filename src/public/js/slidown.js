var hasNextPage = true;

var animation = 22; //parseInt(Math.random() * 67);
var outClass = 'pt-page-scaleDownUp';
var inClass = 'pt-page-scaleDownUp';

switch( animation ) {

  case 1:
  outClass = 'pt-page-moveToLeft';
  inClass = 'pt-page-moveFromRight';
  break;
  case 2:
  outClass = 'pt-page-moveToRight';
  inClass = 'pt-page-moveFromLeft';
  break;
  case 3:
  outClass = 'pt-page-moveToTop';
  inClass = 'pt-page-moveFromBottom';
  break;
  case 4:
  outClass = 'pt-page-moveToBottom';
  inClass = 'pt-page-moveFromTop';
  break;
  case 5:
  outClass = 'pt-page-fade';
  inClass = 'pt-page-moveFromRight pt-page-ontop';
  break;
  case 6:
  outClass = 'pt-page-fade';
  inClass = 'pt-page-moveFromLeft pt-page-ontop';
  break;
  case 7:
  outClass = 'pt-page-fade';
  inClass = 'pt-page-moveFromBottom pt-page-ontop';
  break;
  case 8:
  outClass = 'pt-page-fade';
  inClass = 'pt-page-moveFromTop pt-page-ontop';
  break;
  case 9:
  outClass = 'pt-page-moveToLeftFade';
  inClass = 'pt-page-moveFromRightFade';
  break;
  case 10:
  outClass = 'pt-page-moveToRightFade';
  inClass = 'pt-page-moveFromLeftFade';
  break;
  case 11:
  outClass = 'pt-page-moveToTopFade';
  inClass = 'pt-page-moveFromBottomFade';
  break;
  case 12:
  outClass = 'pt-page-moveToBottomFade';
  inClass = 'pt-page-moveFromTopFade';
  break;
  case 13:
  outClass = 'pt-page-moveToLeftEasing pt-page-ontop';
  inClass = 'pt-page-moveFromRight';
  break;
  case 14:
  outClass = 'pt-page-moveToRightEasing pt-page-ontop';
  inClass = 'pt-page-moveFromLeft';
  break;
  case 15:
  outClass = 'pt-page-moveToTopEasing pt-page-ontop';
  inClass = 'pt-page-moveFromBottom';
  break;
  case 16:
  outClass = 'pt-page-moveToBottomEasing pt-page-ontop';
  inClass = 'pt-page-moveFromTop';
  break;
  case 17:
  outClass = 'pt-page-scaleDown';
  inClass = 'pt-page-moveFromRight pt-page-ontop';
  break;
  case 18:
  outClass = 'pt-page-scaleDown';
  inClass = 'pt-page-moveFromLeft pt-page-ontop';
  break;
  case 19:
  outClass = 'pt-page-scaleDown';
  inClass = 'pt-page-moveFromBottom pt-page-ontop';
  break;
  case 20:
  outClass = 'pt-page-scaleDown';
  inClass = 'pt-page-moveFromTop pt-page-ontop';
  break;
  case 21:
  outClass = 'pt-page-scaleDown';
  inClass = 'pt-page-scaleUpDown pt-page-delay300';
  break;
  case 22:
  outClass = 'pt-page-scaleDownUp';
  inClass = 'pt-page-scaleUp pt-page-delay300';
  break;
  case 23:
  outClass = 'pt-page-moveToLeft pt-page-ontop';
  inClass = 'pt-page-scaleUp';
  break;
  case 24:
  outClass = 'pt-page-moveToRight pt-page-ontop';
  inClass = 'pt-page-scaleUp';
  break;
  case 25:
  outClass = 'pt-page-moveToTop pt-page-ontop';
  inClass = 'pt-page-scaleUp';
  break;
  case 26:
  outClass = 'pt-page-moveToBottom pt-page-ontop';
  inClass = 'pt-page-scaleUp';
  break;
  case 27:
  outClass = 'pt-page-scaleDownCenter';
  inClass = 'pt-page-scaleUpCenter pt-page-delay400';
  break;
  case 28:
  outClass = 'pt-page-rotateRightSideFirst';
  inClass = 'pt-page-moveFromRight pt-page-delay200 pt-page-ontop';
  break;
  case 29:
  outClass = 'pt-page-rotateLeftSideFirst';
  inClass = 'pt-page-moveFromLeft pt-page-delay200 pt-page-ontop';
  break;
  case 30:
  outClass = 'pt-page-rotateTopSideFirst';
  inClass = 'pt-page-moveFromTop pt-page-delay200 pt-page-ontop';
  break;
  case 31:
  outClass = 'pt-page-rotateBottomSideFirst';
  inClass = 'pt-page-moveFromBottom pt-page-delay200 pt-page-ontop';
  break;
  case 32:
  outClass = 'pt-page-flipOutRight';
  inClass = 'pt-page-flipInLeft pt-page-delay500';
  break;
  case 33:
  outClass = 'pt-page-flipOutLeft';
  inClass = 'pt-page-flipInRight pt-page-delay500';
  break;
  case 34:
  outClass = 'pt-page-flipOutTop';
  inClass = 'pt-page-flipInBottom pt-page-delay500';
  break;
  case 35:
  outClass = 'pt-page-flipOutBottom';
  inClass = 'pt-page-flipInTop pt-page-delay500';
  break;
  case 36:
  outClass = 'pt-page-rotateFall pt-page-ontop';
  inClass = 'pt-page-scaleUp';
  break;
  case 37:
  outClass = 'pt-page-rotateOutNewspaper';
  inClass = 'pt-page-rotateInNewspaper pt-page-delay500';
  break;
  case 38:
  outClass = 'pt-page-rotatePushLeft';
  inClass = 'pt-page-moveFromRight';
  break;
  case 39:
  outClass = 'pt-page-rotatePushRight';
  inClass = 'pt-page-moveFromLeft';
  break;
  case 40:
  outClass = 'pt-page-rotatePushTop';
  inClass = 'pt-page-moveFromBottom';
  break;
  case 41:
  outClass = 'pt-page-rotatePushBottom';
  inClass = 'pt-page-moveFromTop';
  break;
  case 42:
  outClass = 'pt-page-rotatePushLeft';
  inClass = 'pt-page-rotatePullRight pt-page-delay180';
  break;
  case 43:
  outClass = 'pt-page-rotatePushRight';
  inClass = 'pt-page-rotatePullLeft pt-page-delay180';
  break;
  case 44:
  outClass = 'pt-page-rotatePushTop';
  inClass = 'pt-page-rotatePullBottom pt-page-delay180';
  break;
  case 45:
  outClass = 'pt-page-rotatePushBottom';
  inClass = 'pt-page-rotatePullTop pt-page-delay180';
  break;
  case 46:
  outClass = 'pt-page-rotateFoldLeft';
  inClass = 'pt-page-moveFromRightFade';
  break;
  case 47:
  outClass = 'pt-page-rotateFoldRight';
  inClass = 'pt-page-moveFromLeftFade';
  break;
  case 48:
  outClass = 'pt-page-rotateFoldTop';
  inClass = 'pt-page-moveFromBottomFade';
  break;
  case 49:
  outClass = 'pt-page-rotateFoldBottom';
  inClass = 'pt-page-moveFromTopFade';
  break;
  case 50:
  outClass = 'pt-page-moveToRightFade';
  inClass = 'pt-page-rotateUnfoldLeft';
  break;
  case 51:
  outClass = 'pt-page-moveToLeftFade';
  inClass = 'pt-page-rotateUnfoldRight';
  break;
  case 52:
  outClass = 'pt-page-moveToBottomFade';
  inClass = 'pt-page-rotateUnfoldTop';
  break;
  case 53:
  outClass = 'pt-page-moveToTopFade';
  inClass = 'pt-page-rotateUnfoldBottom';
  break;
  case 54:
  outClass = 'pt-page-rotateRoomLeftOut pt-page-ontop';
  inClass = 'pt-page-rotateRoomLeftIn';
  break;
  case 55:
  outClass = 'pt-page-rotateRoomRightOut pt-page-ontop';
  inClass = 'pt-page-rotateRoomRightIn';
  break;
  case 56:
  outClass = 'pt-page-rotateRoomTopOut pt-page-ontop';
  inClass = 'pt-page-rotateRoomTopIn';
  break;
  case 57:
  outClass = 'pt-page-rotateRoomBottomOut pt-page-ontop';
  inClass = 'pt-page-rotateRoomBottomIn';
  break;
  case 58:
  outClass = 'pt-page-rotateCubeLeftOut pt-page-ontop';
  inClass = 'pt-page-rotateCubeLeftIn';
  break;
  case 59:
  outClass = 'pt-page-rotateCubeRightOut pt-page-ontop';
  inClass = 'pt-page-rotateCubeRightIn';
  break;
  case 60:
  outClass = 'pt-page-rotateCubeTopOut pt-page-ontop';
  inClass = 'pt-page-rotateCubeTopIn';
  break;
  case 61:
  outClass = 'pt-page-rotateCubeBottomOut pt-page-ontop';
  inClass = 'pt-page-rotateCubeBottomIn';
  break;
  case 62:
  outClass = 'pt-page-rotateCarouselLeftOut pt-page-ontop';
  inClass = 'pt-page-rotateCarouselLeftIn';
  break;
  case 63:
  outClass = 'pt-page-rotateCarouselRightOut pt-page-ontop';
  inClass = 'pt-page-rotateCarouselRightIn';
  break;
  case 64:
  outClass = 'pt-page-rotateCarouselTopOut pt-page-ontop';
  inClass = 'pt-page-rotateCarouselTopIn';
  break;
  case 65:
  outClass = 'pt-page-rotateCarouselBottomOut pt-page-ontop';
  inClass = 'pt-page-rotateCarouselBottomIn';
  break;
  case 66:
  outClass = 'pt-page-rotateSidesOut';
  inClass = 'pt-page-rotateSidesIn pt-page-delay200';
  break;
  case 67:
  outClass = 'pt-page-rotateSlideOut';
  inClass = 'pt-page-rotateSlideIn';
  break;

}

function attachAnim() {
  $("#anim-layer").remove();
  $("body").append('<div id="anim-layer"></div>');
  $("#anim-layer").html($("#wrapper").html());
  $("#anim-layer").attr("class", "apply-animation " + outClass);
  $("#slide").attr("class", inClass);
}

function pageLoaded() {
  prepareHelper();

  loadPage(true);
  loadPage(false);

  window.setTimeout(function() {
    window.addEventListener("popstate", function(e) {
      restorePrevPage();
    }, false);
  }, 1);

  $("#slide-no").html(currentPageNumber());
}

function prepareHelper() {
  if(role == 'Guide') {
    console.log(document.getElementById('helpers'));
    document.getElementById('helpers').innerHTML = [
    '<button title="Previous slide" id="nav-prev" class="nav-prev">&lt;</button>',
    '<button title="Jump to a random slide" id="slide-no"></button>',
    '<button title="Next slide" id="nav-next" class="nav-next">&gt;</button>',
    '<menu>',
    '<button type="checkbox" data-command="toc" title="Table of Contents" class="toc">LIST</button>',
    '<button type="checkbox" data-command="help" title="View Help">?</button>',
    '</menu>'].join('');

    document.getElementById('nav_bar').innerHTML = [
    '<div id="prev_page"></div>',
    '<div id="preloader"></div>'].join('');
  }
}


function genPageUrl(next, partial) {
  var full_path = window.location.href;
  var base_path = full_path.substring(0, full_path.lastIndexOf('/') + 1);
  var next_number = (next ? 1 : -1) + currentPageNumber();
  var postfix = partial ? "?partial=true" : "";

  return base_path + next_number + postfix;
}

function currentPageNumber() {
  var full_path = window.location.href;
  return parseInt(full_path.substring(full_path.lastIndexOf('/') + 1), 10);
}

function loadPage(next) {
  if(!next && currentPageNumber() === 1) {
    return;
  }
  var idName = next ? "#preloader" : "#prev_page";
  $(idName).html("");
  var target_path = genPageUrl(next, true);
  $.ajax({
    url: target_path,
    statusCode: {
      404: function() {
        if(next === true) {
          hasNextPage = false;
        }
      }
    }
  }).done(function(data) {
    $(idName).html(data);
  });
}

function swapHtml(next) {
  attachAnim();
  if(next) {
    $("#prev_page").html($("#wrapper").html());
    $("#wrapper").html($("#preloader").html());
    $("#preloader").html("");
  } else {
    $("#preloader").html($("#wrapper").html());
    $("#wrapper").html($("#prev_page").html());
    $("#prev_page").html("");
  }
}

function nextPage() {
  if(role != 'Guide') return;

  if(!hasNextPage) { // no more page, turn to end page
    alert("The show has came to an end");
  } else {
    if(currentPageNumber() === 0 || $("#preloader").html() === "") { // preloader is too slow
      window.location.href = genPageUrl(true, false);
    } else {
      swapHtml(true);

      // change the url with history api
      history.pushState(null, null, genPageUrl(true, false));

      report();
      window.scroll(0, 0);

      // update page number
      $("#slide-no").html(currentPageNumber());

      loadPage(true);
    }
  }
}

function restorePrevPage() {
  if(role != 'Guide') return;
  if($("#prev_page").html() !== "") {
    swapHtml(false);

    // update page number
    $("#slide-no").html(currentPageNumber());

    loadPage(false);
  }
}

function prevPage() {
  if(role != 'Guide') return;
  history.popstate();
}

document.onkeypress = function(e) {
  e = window.event || e;
  if (e.charCode == 32 ) { // space is pressed
    nextPage();
  } else if (e.charCode == 98) {
    prevPage();
  }
};

document.onkeydown = function(e) {
  e = window.event || e;
  if (e.keyCode == 34 ) {
    nextPage();
  } else if (e.keyCode == 33) {
    prevPage();
  }
};

document.onclick = function(e) {
  nextPage();
};

document.ontouchmove = function(e) {
  nextPage();
};
