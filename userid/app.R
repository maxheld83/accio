#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)

# Define UI for application that draws a histogram
ui <- basicPage(
  useShinyjs()
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  # reactiveValues object for storing current data set.
  vals <- reactiveValues(data = NULL)

  # Return the UI for a modal dialog with data selection input. If 'failed' is
  # TRUE, then display a message that the previous value was invalid.
  dataModal <- function(failed = FALSE) {
    modalDialog(
      h4("QWrks Erhebung", code("sublab")),
      p("Vielen Dank, dass Sie an unserer Studie zu subjektiven Arbeitswelten der Zukunft teilnehmen."),
      textInput(inputId = "fakename",
                label = "Pseudonym",
                placeholder = "Bitte merken Sie sich diesen Namen"
      ),
      radioButtons(inputId = "gender",
                   label = "Geschlecht",
                   choiceNames = c("weiblich", "männlich", "andere", "keine Angabe"),
                   choiceValues = c("female", "male", "other", "no response"),
                   inline = TRUE,
                   selected = "no response"
      ),
      numericInput(inputId = "age",
                   label = "Alter",
                   value = NA,
                   min = 1,
                   max = 130,
                   step = 1
      ),

      footer = tagList(
        actionButton(inputId = "submit_fakename",
                     label = "Weiter")
      )
    )
  }

  observe({
    shinyjs::toggleState(id = "submit_fakename",
                         condition = !is.null(input$fakename) && input$fakename != "")
  })

  showModal(dataModal())

  # When OK button is pressed, attempt to load the data set. If successful,
  # remove the modal. If not show another modal, but this time with a failure
  # message.
  observeEvent(input$submit_fakename, {
    # Check that data object exists and is data frame.
    if (!is.null(input$fakename) && nzchar(input$fakename)) {
      vals$data <- get(input$dataset)
      removeModal()
    } else {
      showModal(dataModal(failed = TRUE))
    }
  })

  # Display information about selected data
  output$dataInfo <- renderPrint({
    if (is.null(vals$data))
      "No data selected"
    else
      summary(vals$data)
  })
}

# Run the application
shinyApp(ui = ui, server = server)

