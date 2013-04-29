var hasNextPage = true;

function pageLoaded() {
  preloadNextPage();
  window.addEventListener("popstate", function(e) {
    console.log(location.pathname);
  });
}

function nextPageUrl(partial) {
  var full_path = window.location.href;
  var base_path = full_path.substring(0, full_path.lastIndexOf('/') + 1);
  var next_number = currentPageNumber() + 1;

  var postfix = "";
  if(partial) {
    postfix = "?partial=true";
  }

  return base_path + next_number + postfix;
}

function currentPageNumber() {
  var full_path = window.location.href;
  return parseInt(full_path.substring(full_path.lastIndexOf('/') + 1), 10);
}

function preloadNextPage() {
  $("#preloader").html("");
  var new_path = nextPageUrl(true);
  $.ajax({
    url: new_path,
    statusCode: {
      404: function() {
        hasNextPage = false;
      }
    }
  }).done(function(data) {
    $("#preloader").html(data);
  });
}

function nextPage() {
  if(!hasNextPage) { // no more page, turn to end page
    alert("The show has came to an end");
  } else {
    if($("#preloader").html() === "" || currentPageNumber === 0) { // preloader is too slow
      console.log(nextPageUrl(false));
      window.location.href = nextPageUrl(false);
    } else {
      // move preloaded html into current wrapper
      $("#wrapper").html($("#preloader").html());

      // change the url with history api
      history.pushState(null, null, nextPageUrl(false));

      // now that the url has changed, we can continue preloading
      preloadNextPage();
    }
  }
}

function prevPage () {
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
