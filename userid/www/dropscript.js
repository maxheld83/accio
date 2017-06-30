function(event, ui) {
  // The following happens to RECEIVING parent cells on drop
  // child from SENDING parent was a clone appended to grid, so must first be appended to receiving parent
  ui.draggable.detach().appendTo($(this));
  /*console.log(ui.draggable.attr("id"));*/
  $(this)
    // change layout appropriately
    .removeClass("free")
    // prevent other draggable from being dropped on top
    .droppable("disable")
    // allow receiving parent to scale
    .click(function() {
      $(this)
        // scale in-out currently clicked cell
        .toggleClass("zoom-in")
        // clicked must never be transparent
        .removeClass("scale-contrast");
      if ($(this).hasClass("zoom-in")) {
        // in case the clicked cell becomes toggled ON, scale out all others and make them transparent
        $(this)
          .siblings(".cell")
          .has(".item")
          .addClass("scale-contrast")
          .removeClass("zoom-in");
      } else {
        // in case the clicked cell becomes toggled OFF, make all others opaque
        $(this)
          .siblings(".cell")
          .has(".item")
          .removeClass("scale-contrast");
      }
    });

  // the following happens to SENDING parent cells, which are now orphaned
  // notice that there is no "dropout" event, so we here shoehorn the DROP event into the same purpose by selecting all "empty" (sic!) parent cells on drop
  // however, the actual "empty" selector does NOT work reliably:  $(".droppable:empty")
  // hence the :not:has action. enjoy.
  $(".droppable:not(:has(.draggable))")
    // revert what happens on "drop" in the above
    .addClass("free")
    // unscale the sending cell (remove artefact)
    .removeClass("zoom-in")
    // make the sending cell droppable again
    .droppable("enable");

  // ensure that sending cells are no longer scalable
  $(".cell:not(:has(.item))")
    .off("click");

  // we also revert the scale-contrast of the unscaled item cells
  $(".cell")
    .removeClass("scale-contrast");

  //console.log(ui.draggable.attr("id"));
  //return ui.draggable.attr("id");
}
