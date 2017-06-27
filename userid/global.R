library(shiny)
library(shinyforms)

questions <- list(
  list(id = "name", type = "text", title = "Name", mandatory = TRUE),
  list(id = "age", type = "numeric", title = "Age"),
  list(id = "favourite_pkg", type = "text", title = "Favourite R package"),
  list(id = "terms", type = "checkbox", title = "I agree to the terms")
)

formInfo <- list(
  id = "basicinfo",
  questions = questions,
  storage = list(
    # Right now, only flat file storage is supported
    type = STORAGE_TYPES$FLATFILE,
    # The path where responses are stored
    path = "responses"
  )
)
