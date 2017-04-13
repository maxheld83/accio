shinyUI(fluidPage(
  includeJqueryUI(),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
  ),
  titlePanel("title panel"),

  sidebarLayout(
    mainPanel(
      h3("Items"),
      tags$div(
        HTML(read_file(file = "www/grid.html"))
      )
    ),
    sidebarPanel(
      "sidebar panel",
      shiny::textOutput(outputId = "text1"),
      tags$div(
        HTML(read_file(file = "www/items.html"))
      )
    )
  )
))
