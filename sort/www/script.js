$(function() {
  $(".draggable").draggable({
    snap: ".droppable",
    snapMode: "inner",
    snapTolerance: 10,
    opacity: 0.7,
    addClasses: true,
    scroll: true,
    cursor: "move",
    stack: ".item",
    revert: "invalid",
    appendTo: ".grid",
    helper: "clone",
    containment: ".grid",
    start: function() {
      $(this).hide();
    },
    stop: function() {
      $(this).show();
    }
  });
  $(".droppable").droppable({
    tolerance: "intersect",
    accept: ".draggable",
    greedy: true,
    over: function(event, ui) {
      // Enable all the .droppable elements
      $('.droppable').droppable('enable');

      // If the droppable element we're hovered over already contains a .draggable element,
      // don't allow another one to be dropped on it
      if ($(this).has('.draggable').length) {
        $(this).droppable('disable');
      }
    },
    drop: function(event, ui) {
      ui.draggable.detach().appendTo($(this));
      // $(this).removeClass("droppable");
      //   $(this).droppable("disable");
      //   // $(".droppable").droppable("enable");
    },
  });
});
