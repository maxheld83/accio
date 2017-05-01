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

  tags$div(HTML(read_file(file = "www/grid.html"))),
      # tags$div(
      #   HTML(read_file(file = "www/items.html"))
      # )
  tags$p("Bitte sortieren Sie von die Aussagen von links nach rechts nach dem Grad ihrer Zustimmung.
         Links die Aussagen, die Sie ablehnen, und rechts die Aussagen, denen Sie zustimmen.")
))
