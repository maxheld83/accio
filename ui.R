library(shinyjqui)
library(shiny)
library(ggplot2)

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
      jqui_draggabled(tag = shiny::textInput(inputId = 'item1', label = 'Item 1')),
      jqui_draggabled(tag = shiny::textInput(inputId = 'item2', label = 'Item 2')),
      jqui_draggabled(tag = shiny::textInput(inputId = 'item3', label = 'Item 3')),
      jqui_droppabled(tag = shiny::textInput(inputId = 'dropzone', label = 'Drop Zone'))
    )
  )
))
