shinyServer(function(input, output) {

  output$item_preview <- renderText(expr = {
    input$item_render
    isolate(expr = {
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
      return(new_item)
    })
  })
})
