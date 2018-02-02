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

  # create example csv
  output$example <- shiny::renderPrint(
    expr = {
      items <- c(
        foo = "full wording for 'foo' item in",
        bar = "full wording for 'bar' item in"
      )
      m <- matrix(
        data = apply(
          X = expand.grid(items, languages(), stringsAsFactors = FALSE),
          MARGIN = 1,
          FUN = function(x) paste(x, collapse = " ")
        ),
        nrow = 2,
        dimnames = list(items = names(items), languages = languages())
      )
      df <- data.frame(handle = rownames(m))
      df <- cbind(df, as.data.frame(m))
      write.table(
        x = df,
        file = "",
        row.names = FALSE,
        col.names = input$header,
        sep = input$sep,
        quote = TRUE
      )
    })

   # upload and process actual csv
  concourse <- reactive({
    if (is.null(inFile)) {
      return(NULL)
    } else {
      csv <- read.csv(inFile$datapath, header = input$header)
    }

  })

})
