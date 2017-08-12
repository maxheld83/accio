shinyServer(function(input, output) {

  output$item_preview <- renderText(expr = {
    validate(
      need(expr = {input$item_handle != ""},
           label = "Item Handle")
    )
    input$item_handle
  })
})
