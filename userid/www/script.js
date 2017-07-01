$(function() {
  $(".draggable").draggable({
    // option cursorAt is set dynamically in the below

    // snap is an option, but does not work great.
    // snap: ".free",
    // snapMode: "inner",
    // snapTolerance: 10,
    scroll: true,
    cursor: "move",
    // go back to original place, if placed on invalid droppable
    revert: "invalid",
    // this makes sure that we can escape the parent
    appendTo: ".grid",
    // necessary to espace the parent
    helper: function () { return $(this).clone()},
    // prevents draggint outside of grid
    containment: ".grid",
    start: function(event, ui) {
      // original must be hidden on start of dragging clone
      $(this)
        .hide();
      $(".cell")
        .removeClass("zoom-in scale-contrast");
    },

    create: function(event, ui) {
      // calculate cursorAt the first time draggable is created, updated below when viewport changes
      $(this).draggable("option", "cursorAt", {
        left: Math.floor(this.clientWidth / 2),
        top: Math.floor(this.clientHeight / 2)
      });
    },

    stop: function() {
      // and original shown again, once clone is appended
      $(this)
        .show();
    }
  });

  $(window).resize(function() {
    // TODO this is atrocious code that evaluates many times on a resize; eval should wait until resize is done. -> https://github.com/maxheld83/accio/issues/141
    // first grab ONE of item class
    var firstitem = document.getElementsByClassName("item")[0];
    // then recalculate cursorAt based on dims of this one item
    $(".draggable").draggable("option", "cursorAt", {
      left: Math.floor(firstitem.clientWidth / 2),
      top: Math.floor(firstitem.clientHeight / 2)
    });
  });

  // $(".droppable").droppable({
  //   // this is too generous
  //   tolerance: "pointer",
  //   accept: ".draggable",
  //   drop: function(event, ui) {
  //     // The following happens to RECEIVING parent cells on drop
  //     // child from SENDING parent was a clone appended to grid, so must first be appended to receiving parent
  //     ui.draggable.detach().appendTo($(this));
  //     $(this)
  //       // change layout appropriately
  //       .removeClass("free")
  //       // prevent other draggable from being dropped on top
  //       .droppable("disable")
  //       // allow receiving parent to scale
  //       .click(function() {
  //         $(this)
  //           // scale in-out currently clicked cell
  //           .toggleClass("zoom-in")
  //           // clicked must never be transparent
  //           .removeClass("scale-contrast");
  //         if ($(this).hasClass("zoom-in")) {
  //           // in case the clicked cell becomes toggled ON, scale out all others and make them transparent
  //           $(this)
  //             .siblings(".cell")
  //             .has(".item")
  //             .addClass("scale-contrast")
  //             .removeClass("zoom-in");
  //         } else {
  //           // in case the clicked cell becomes toggled OFF, make all others opaque
  //           $(this)
  //             .siblings(".cell")
  //             .has(".item")
  //             .removeClass("scale-contrast");
  //         }
  //       });
  //
  //     // the following happens to SENDING parent cells, which are now orphaned
  //     // notice that there is no "dropout" event, so we here shoehorn the DROP event into the same purpose by selecting all "empty" (sic!) parent cells on drop
  //     // however, the actual "empty" selector does NOT work reliably:  $(".droppable:empty")
  //     // hence the :not:has action. enjoy.
  //     $(".droppable:not(:has(.draggable))")
  //       // revert what happens on "drop" in the above
  //       .addClass("free")
  //       // unscale the sending cell (remove artefact)
  //       .removeClass("zoom-in")
  //       // make the sending cell droppable again
  //       .droppable("enable");
  //
  //     // ensure that sending cells are no longer scalable
  //     $(".cell:not(:has(.item))")
  //       .off("click");
  //
  //     // we also revert the scale-contrast of the unscaled item cells
  //     $(".cell")
  //       .removeClass("scale-contrast");
  //   },
  // });
});

// INIT
$(function() {
  // notice this always has to happen at the parent CELL level, not the child item level, because otherwise you can't scale outside of the containing cell.
  // must also use scale so as not to disrupt the flow of cells (scale results are ignored in boxmodel etc.)
  // this must happen at the very beginning, BEFORE any drop event is triggered
  // this initial assignment is then added/removed on any drop event in above .droppable function
  $(".cell").has(".item").click(function() {
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
  // initial droppables must also be disabled if they are already filled
  // this is a rare use case, but will be used when item are dynamically presented as in item-response theory settings
  $(".droppable:has(.draggable)").droppable("disable");
});

// The following code prevents overflow when scaling items. The items should only scale inside container(.grid)
// TODO: Why option false?
document.addEventListener("DOMContentLoaded", setEvent, false);
// window.addEventListener("resize", setEvent);

$(window).resize(function() {
  setEvent();
});

function setEvent() {
  var elements = document.getElementsByClassName("cell");
  // compare all of the below to grandparent dimensions (gridcontainer)
  var grid = elements[0].parentElement.parentElement;
  // calculate dimensions of grid. We need this to compare it with item positions below.

  var gridWidth = grid.clientWidth;
  var gridHeight = grid.clientHeight;
  var maxGrid = {
    right: gridWidth,
    bottom: gridHeight
  }

  for (var n = 0; n < elements.length; n++) {
    evaluate(elements[n], maxGrid);
  }
};

function evaluate(element, maxGrid) {

  // We need the declare variable "transOrigin" to put it into the .transformOrigin method later on in order to transform item position.

  var transOrigin = " ";


  // This is the important part, where we compare item position with grid dimensions and say how the item should be transformed in which case (left, right, bottom, top).

  var left = element.offsetLeft;
  if (left < element.clientWidth / 2) {
    transOrigin += "left ";
  } else if (left + (element.clientWidth / 2) > maxGrid.right - element.clientWidth) {
    transOrigin += "right ";
  } else {
    transOrigin += "center ";
  }

  // for the available space on top or bottom of cells, we need to know the distance of every cell from its GRANDPARENT gridcontainer
  // because this is not easily available, we first calculate the offset from parent (grid) to grandparent (gridcontainer) and add these up.
  var whitespacetop = element.parentElement.offsetTop;
  var top = element.offsetTop + whitespacetop;
  if (top < element.clientHeight / 2) {
    transOrigin += "top";
  } else if (top + (element.clientHeight / 2) > maxGrid.bottom - element.clientHeight) {
    transOrigin += "bottom";
  } else {
    transOrigin += "center";
  }

  // Finally, the transformOrigin property sets the position on items ('x-axis y-axis z-axis').
  element.style.transformOrigin = transOrigin;
}


// when the grid is "wider" (in terms of aspect ratio) than the gridcontainer (happens rarely), the dimensions of the grid must be resized to fit
// specifically, only the width can/must be resized, because all dimensions in grid depend only on grid.
function squishvertical(heightneed) {
  var outeraspect = $(".gridcontainer")[0].clientWidth / $(".gridcontainer")[0].clientHeight;
  var spacefortext = $("#condition")[0].clientHeight * 2 + ($("#extremes1")[0].clientHeight * 2);
  var inneraspect = $(".grid")[0].clientWidth / ($(".grid")[0].clientHeight + spacefortext);
  if (outeraspect > inneraspect) {
    // attention: this part of the if clause writes out pixels, not percent
    var heightneed = $(".grid")[0].clientHeight + spacefortext;
    var heightavail = $(".gridcontainer")[0].clientHeight;
    var widthfactor = heightavail / heightneed;
    var newwidth = widthfactor * $(".grid")[0].clientWidth;
    $(".grid").css("width", newwidth);
  } else {
    $(".grid").css("width", "100%");
  }
}

document.addEventListener("DOMContentLoaded", squishvertical, false);
$(window).resize(function() {
  // squishvertical();
});
