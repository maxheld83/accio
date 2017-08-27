shinyServer(function(input, output, session) {

  showModal(modalDialog(
    title = "Enter a New Item",
    textInput(inputId = "item_handle",
                     label = "Item handle (researcher-facing):",
                     placeholder = "Only letters, numbers, '.' and '_'"),
    textAreaInput(inputId = "item_full",
                         label = "Full item wording (participant-facing)",
                         placeholder = "Plain text.",
                         height = '10pc',
                         resize = "vertical"),
    textOutput(outputId = "item_preview"),
    easyClose = TRUE,
    size = "l",
    fade = FALSE,
    footer = tagList(
      modalButton(label = "Cancel"),
      # init button as disabled
      shinyBS::bsButton(inputId = "submit", label = "Submit", disabled = TRUE)  # this is a hack-fix until we get shinyJS
      # actionButton(inputId = "submit", label = "Submit")
    )
  ))

  output$item_preview <- renderText(expr = {
    #TODO disable button here via shinyjs once vailable
    req(input$item_handle, input$item_full)
    new_item <- pensieve::ItemConcourse(
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
    #TODO enable button here via shinyjs once available
    shinyBS::updateButton(session = session, inputId = "submit", label = "Submit", disabled = FALSE)
    return(new_item)
  })
})
