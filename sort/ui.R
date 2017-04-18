library(shiny)
library(shinyjqui)
library(readr)

shinyUI(fluidPage(
  includeJqueryUI(),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css")),

  # sidebarLayout(
  #
  #   sidebarPanel(
  #     "sidebar panel",
  #     shiny::textOutput(outputId = "text1")
  #   ),

    mainPanel(
      tags$div(
        HTML(read_file(file = "www/grid.html"))
      )
      # tags$div(
      #   HTML(read_file(file = "www/items.html"))
      # )
    )
  )
)
