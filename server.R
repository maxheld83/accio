shinyServer(function(input, output) {

  showModal(modalDialog(
    title = "Enter a New Item",
    shiny::textInput(inputId = "item_handle",
                     label = "Item handle (researcher-facing):",
                     placeholder = "Only letters, numbers, '.' and '_'"),
    shiny::textAreaInput(inputId = "item_full",
                         label = "Full item wording (participant-facing)",
                         placeholder = "Plain text.",
                         height = '10pc',
                         resize = "vertical"),
    shiny::textOutput(outputId = "item_preview"),
    easyClose = TRUE,
    size = "l",
    fade = FALSE,
    footer = tagList(
      modalButton(label = "Cancel"),
      actionButton(inputId = "submit", label = "Submit")
    )
  ))

  output$item_preview <- renderText(expr = {
    shinyjs::disable(id = "submit")  # start with disabled button
    req(input$item_handle, input$item_full)
    new_item <- QItemConcourse(
      concourse = matrix(
        data = input$item_full,
        nrow = 1,
        ncol = 1,
        dimnames = list(items = input$item_handle, languages = c("english"))
      ),
      validate = FALSE
    )

    validate(
      need(x = new_item, label = "Item handle or full text")
    )
    shinyjs::enable(id = "submit")  # only enable button on successful test
    return(new_item)
  })
})
