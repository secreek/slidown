function nextPage() {
    base_path = window.location.href;
    base_path = base_path.substring(0, base_path.lastIndexOf('/') + 1);

    first_child = get_meta('first_child');
    next_sib = get_meta('next_sib');
	next = get_meta('next');

    // if(first_child != "") {
    //   base_path += first_child;
    // } else if(next_sib != "") {
    //   base_path += next_sib;
	if (next != "") {
      base_path += next;
    } else {
      alert('The Show has come to an end');
      return;
    }
    window.location = base_path;
}

document.onkeypress = function(e) {
  var e = window.event || e;
  if (e.charCode == 32) { // space is pressed
	nextPage();
  }
}

document.onmousedown = function(e) {
	nextPage();
}