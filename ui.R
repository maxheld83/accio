library(shinyjqui)
library(shiny)
library(ggplot2)

shinyUI(fluidPage(
  includeJqueryUI(),
  titlePanel("title panel"),

  sidebarLayout(
    sidebarPanel(
      "sidebar panel",
      #shiny::textOutput(outputId = "text1"),
      shiny::textOutput(outputId = "text2"),
      shiny::textOutput(outputId = "text3"),
      shiny::textOutput(outputId = "text4")
    ),
    mainPanel(
      strong("main panel"),
      jqui_draggabled(tag = shiny::textInput(inputId = 'item1', label = 'Item 1')),
      jqui_draggabled(tag = shiny::textInput(inputId = 'item2', label = 'Item 2')),
      jqui_draggabled(tag = shiny::textInput(inputId = 'item3', label = 'Item 3')),
      jqui_droppabled(tag = shiny::textInput(inputId = 'dropzone', label = 'Drop Zone'),
                      options = list(
                        shiny = list(
                          # By default, draggable element has a shiny input value showing the element's
                          # position (relative to the parent element). Here, another shiny input
                          # value is added. It gives the element's offset (position relative to the
                          # document). Using input$foo_offset to get access to it .
                          dropped = list(
                            # return the initiated offset value when the draggable is created
                            # dropcreate = NA,
                            # update the offset value while dragging
                            # drop = p("foobar")
                            drop = htmlwidgets::JS('function(event, ui) { return $(event.result).droppable(); }')
                          )
                        )
                     )
      )
    )
  )
))
