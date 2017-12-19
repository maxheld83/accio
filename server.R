shinyServer(function(input, output, session) {

  # conditional ui stuff
  observe({
    shinyjs::toggleElement(
      id = "markup",
      condition = input$type == "text"
    )
  })
  observe({
    if (input$babel) {
      shinyjs::show(id = "languages_babel")
      shinyjs::hide(id = "languages_any")
    } else {
      shinyjs::hide(id = "languages_babel")
      shinyjs::show(id = "languages_any")
    }
  })

  # first find languages from two different forms of inputting them
  languages <- reactive({
    if (input$babel) {
      input$languages_babel
    } else {
      unlist(strsplit(x = input$languages_any, split = ","))
    }
  })

})
