function nextPage() {
    base_path = window.location.href;
    base_path = base_path.substring(0, base_path.lastIndexOf('/') + 1);

    first_child = get_meta('first_child');
    next_sib = get_meta('next_sib');
<<<<<<< HEAD
	next = get_meta('next');
=======
    next = get_meta('next');
>>>>>>> 210135939bde3e2531edbcac9726221b601344fc

    // if(first_child != "") {
    //   base_path += first_child;
    // } else if(next_sib != "") {
    //   base_path += next_sib;
<<<<<<< HEAD
	if (next != "") {
=======
	if (next !== "") {
>>>>>>> 210135939bde3e2531edbcac9726221b601344fc
      base_path += next;
    } else {
      alert('The Show has come to an end');
      return;
    }
    window.location = base_path;
}

<<<<<<< HEAD
=======
function prevPage () {
  history.go(-1);
}

>>>>>>> 210135939bde3e2531edbcac9726221b601344fc
document.onkeypress = function(e) {
  var e = window.event || e;
  if (e.charCode == 32) { // space is pressed
	nextPage();
  }
<<<<<<< HEAD
}

document.onclick = function(e) {
	nextPage();
}

document.ontouchmove = function(e) {
	nextPage();
}
=======
};

document.onclick = function(e) {
	nextPage();
};

document.ontouchmove = function(e) {
	nextPage();
};
>>>>>>> 210135939bde3e2531edbcac9726221b601344fc
