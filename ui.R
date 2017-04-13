shinyUI(fluidPage(
  includeJqueryUI(),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
  ),
  titlePanel("title panel"),

  sidebarLayout(
    sidebarPanel(
      "sidebar panel",
      shiny::textOutput(outputId = "text1")
    ),
    mainPanel(
      h3("Items"),
      tags$div(
        HTML(read_file(file = "www/index.html"))
      )
    )
  )
))
