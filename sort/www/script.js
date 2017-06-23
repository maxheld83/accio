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
    // stack: ".item",
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
    drop: function(event, ui) {
      // append the clone as a child
      ui.draggable.detach().appendTo($(this));
      // remove the free class, necessary because opacity otherwise won't work
      $(this).removeClass("free");
      $(this).droppable("disable");
      // but ALSO check on drop whether some OTHER droppable is now empty (the place of origin, probably), and mark it as free
      // notice that this is a workaround for a "dropout" event, which would be nice, but does not exis
      // The following selector does not work relieably: $(".droppable:empty")

      $(".droppable:not(:has(.draggable))")
        .addClass("free")
        .droppable("enable");
    },
  });
});

//   scale cells
//   $(".cell").not(".free").click(function() {
//     $(this).toggleClass("zoom-in");
//   });
// })

// The following code prevents overflow when scaling items. The items should only scale inside container (.grid)
//
// document.addEventListener("DOMContentLoaded", setEvent, false);
//
// function setEvent() {
//   var elements = document.getElementsByClassName("cell");
//   var grid = elements[0].parentElement;
//
//   // calculate dimensions of grid. We need this to compare it with item positions below.
//
//   var gridWidth = grid.clientWidth;
//   var gridHeight = grid.clientHeight;
//   var maxGrid = {
//     right: gridWidth,
//     bottom: gridHeight
//   }
//
//   for (var n = 0; n < elements.length; n++) {
//     evaluate(elements[n], maxGrid);
//   }
// }
//
// function evaluate(element, maxGrid) {
//
//   // We need the declare variable "transOrigin" to put it into the .transformOrigin method later on in order to transform item position.
//
//   var transOrigin = "";
//
//   // This is the important part, where we compare item position with grid dimensions and say how the item should be transformed in which case (left, right, bottom, top).
//
//   var left = element.offsetLeft;
//   if (left < element.clientWidth / 2) {
//     transOrigin += "left ";
//   }
//   if (left + element.clientWidth / 2 > maxGrid.right - element.clientWidth) {
//     transOrigin += "right";
//   }
//
//
//   var top = element.offsetTop;
//   if (top < element.clientHeight / 2) {
//     transOrigin += "top";
//   }
//   if (top + element.clientHeight / 2 > maxGrid.bottom - element.clientHeight) {
//     transOrigin += "bottom";
//   }
//
//   // Finally, the transformOrigin property sets the position on items ('x-axis y-axis z-axis').
//
//   element.style.transformOrigin = transOrigin;
// }
// n = transOrigin;
// }
