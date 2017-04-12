shinyUI(fluidPage(
  includeJqueryUI(),
  titlePanel("title panel"),

  sidebarLayout(
    sidebarPanel(
      "sidebar panel",
      shiny::textOutput(outputId = "text1")
    ),
    mainPanel(
      strong("main panel"),
      jqui_draggabled(div(id = 'item-1', class = 'item',
          'I am Item 1.')),
      jqui_draggabled(div(id = 'item-2', class = 'item',
          'I am Item 2.')),
      jqui_droppabled(tag = div(id = 'dropzone', class = 'item',
                          'I am the dropzone.'),
                      options = list(
                        shiny = list(
                          dropped = list(
                            drop = htmlwidgets::JS('function(event, ui) { return ui.draggable.attr("id");}')
                          )
                        )
                      ))
    )
  )
))
