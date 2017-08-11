shinyUI(bootstrapPage(

  shiny::textInput(inputId = "item_handle",
                   label = "Short handle for item (researcher-facing):",
                   placeholder = "Must be valid R name."),

  shiny::textAreaInput(inputId = "item_full",
                       label = "Full wording for item (participant-facing)",
                       placeholder = "Must be plain text.",
                       height = '10pc',
                       resize = "vertical"),

  shiny::actionButton(inputId = "item_render",
                      label = "Preview"),

  shiny::textOutput(outputId = "item_preview")
))
