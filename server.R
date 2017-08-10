shinyServer(function(input, output) {

  output$item_preview <- renderText(expr = input$item_full)
})
