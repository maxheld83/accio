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
library(rdrop2)
library(shinyjqui)
library(readr)

# Define UI for application that draws a histogram
ui <- fillPage(
  useShinyjs(),
  includeJqueryUI(),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "font-awesome.css"),
    tags$script(src = "script.js")
  ),

  # sidebarLayout(
  #
  #   sidebarPanel(
  #     "sidebar panel",
  #     shiny::textOutput(outputId = "text1")
  #   ),

  HTML(read_file(file = "www/index.html"))
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

  # showModal(dataModal())
  res <- NULL
  res$time_start <- Sys.time()

  observeEvent(input$submit_fakename, {
      res$time_namesubmit <- Sys.time()
      res$input <- reactiveValuesToList(input)

      # input <- NULL
      # input$fakename <- "Lisa"
      filename <- paste0(res$input$fakename, "_", res$time_start, ".rds")
      filepath <- file.path(tempdir(), filename)

      # filepath <- tempdir()
      # validation <- readRDS(file = "../../Dropbox/qsort/nonreact_2017-06-29 21:06:46.rds")
      saveRDS(object = res, file = filepath)

      # token <- drop_auth()
      # saveRDS(object = token, file = "droptoken.rds")
      token <- readRDS(file = "droptoken.rds")
      drop_upload(file = filepath,
                  dtoken = token,
                  dest = "qsort",
                  overwrite = FALSE,
                  autorename = TRUE)
      removeModal()
  })
}

# Run the application
shinyApp(ui = ui, server = server)

