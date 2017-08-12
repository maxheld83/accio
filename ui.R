shinyUI(bootstrapPage(

  shiny::textInput(inputId = "item_handle",
                   label = "Item handle (researcher-facing):",
                   placeholder = "Only letters, numbers, '.' and '_'"),

  shiny::textAreaInput(inputId = "item_full",
                       label = "Full item wording (participant-facing)",
                       placeholder = "Plain text.",
                       height = '10pc',
                       resize = "vertical"),

  shiny::actionButton(inputId = "item_render",
                      label = "Preview"),

  shiny::textOutput(outputId = "item_preview")
))
