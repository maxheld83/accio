shinyUI(fluidPage(
  titlePanel("title panel"),

  sidebarLayout(
    sidebarPanel( "sidebar panel"),
    mainPanel(
      strong("main panel"),
      shiny::checkboxGroupInput(inputId = "some_choice",
                                label = "Some Choice",
                                choices = list("foo" = "foo", "bar" = "bar", "blah" = "blah")
      ),
      shiny::textOutput(outputId = "text1")
    )
  )
))
