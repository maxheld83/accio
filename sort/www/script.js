$(function() {
  $(".draggable").draggable({
    // only snap to whatever is actually marked free in thml
    snap: ".free",
    snapMode: "inner",
    snapTolerance: 10,
    opacity: 0.7,
    addClasses: true,
    scroll: true,
    cursor: "move",
    stack: ".item",
    // go back to original place, if placed on invalid droppable
    revert: "invalid",
    // this makes sure that we can escape the parent
    appendTo: ".grid",
    // necessary to espace the parent
    helper: "clone",
    // prevents draggint outside of grid
    containment: ".grid",
    start: function() {
      // original must be hidden on start of dragging clone
      $(this).hide();
    },
    stop: function() {
      // and original shown again, once clone is appended
      $(this).show();
    }
  });
  $(".droppable").droppable({
    // this is too generous
    tolerance: "intersect",
    accept: ".draggable",
    greedy: true,
    over: function(event, ui) {
      // Enable all the .droppable elements by default
      $('.droppable').droppable('enable');

      // If the droppable element we're hovered over already contains a .draggable element, don't allow another one to be dropped on it
      if ($(this).has('.draggable').length) {
        $(this).droppable('disable');
      };
    },
    drop: function(event, ui) {
      // append the clone as a child
      ui.draggable.detach().appendTo($(this));
      // remove the free class, necessary because opacity otherwise won't work
      $(this).removeClass("free");
      // but ALSO check on drop whether some OTHER droppable is now empty (the place of origin, probably), and mark it as free gradients
      // notice that this is a workaround for a "dropout" event, which would be nice, but does not exist
      $(".droppable:empty").addClass("free");
    },
  });
});
