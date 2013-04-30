var hasNextPage = true;

function attachAnim() {
  $("#anim-layer").remove();
  $("body").append('<div id="anim-layer"></div>');
  $("#anim-layer").html($("#wrapper").html());
  $("#anim-layer").attr("class", "apply-animation");
}

function pageLoaded() {
  loadPage(true);
  loadPage(false);

  window.setTimeout(function() {
    window.addEventListener("popstate", function(e) {
      restorePrevPage();
    }, false);
  }, 1);

  $("#slide-no").html(currentPageNumber());
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
  if($("#prev_page").html() !== "") {
    swapHtml(false);

    // update page number
    $("#slide-no").html(currentPageNumber());

    loadPage(false);
  }
}

function prevPage() {
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
