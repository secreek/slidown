$(document).ready(bindVoting());

function bindVoting() {
  $("input:radio").each(function(index, button) {
    console.log(button);
    console.log($(button));
  });
}
