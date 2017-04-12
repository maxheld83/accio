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
      ),
      h3("Test"),
      strong("main panel"),
      div(id = 'item-1', class = 'item', 'I am Item 1.'),
      div(id = 'item-2', class = 'item', 'I am Item 2.'),
      div(id = 'dropzone', class = "cell", "I am the dropzone")
    )
  )
))
