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
    tags$script(src = "script.js")
  ),

  div(
    class = "gridcontainer",
    div(
      id = "condition",
      class = "gridlabel",
      style = "margin-bottom: -2%",
      h3("Was möchten Sie zukünftig über ihre Arbeit sagen können?")
    ),
    div(
      id = "extremes1",
      class = "gridlabel",
      span(
        class = "leftlabel",
        style = "padding-right: 15%",
        icon(name = "arrow-left", lib = "font-awesome"),
        "Trifft eher nicht zu."
      ),
      span(
        class = "rightlabel",
        style = "padding-left: 15%",
        "Trifft eher zu.",
        icon(name = "arrow-right", lib = "font-awesome")
      ),
      div(
        style = "clear: both"
      )
    ),
    # print(do.call(
    #   div,
    #   c(
    #     id = "grid",
    #     class = "grid ncol09",
    #     replicate(
    #     n = 22,
    #     simplify = FALSE,
    #     expr = div(class = "hexagon cell droppable free")
    #     ),
    #     list(
    #       div(
    #         class = "hexagon cell droppable free",
    #         id = "c-05"
    #       )
    #     ),
    #     replicate(
    #       n = 22,
    #       simplify = FALSE,
    #       expr = div(class = "hexagon cell droppable free")
    #     )
    #   )
    # )),
    HTML(text = read_file(file = "www/index.html")),
    div(
      id = "extremes1",
      class = "gridlabel",
      span(
        class = "leftlabel",
        style = "padding-right: 15%",
        icon(name = "arrow-left", lib = "font-awesome"),
        "Trifft eher nicht zu."
      ),
      span(
        class = "rightlabel",
        style = "padding-left: 15%",
        "Trifft eher zu.",
        icon(name = "arrow-right", lib = "font-awesome")
      ),
      div(
        style = "clear: both"
      ),
      div("foo"),
      textOutput(outputId = "text1", inline = FALSE)
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
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
  res$desirable <- desirable

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

  jqui_droppable(
    selector = ".droppable",
    options = list(
      tolerance = "pointer",
      accept = ".draggable",
      drop = htmlwidgets::JS(
        read_file("www/dropscript.js")
      )
    )
  )

  observeEvent(
    eventExpr = {
      paste(
      input$a01_drop,
      input$a02_drop,
      input$a03_drop,
      input$a04_drop,
      input$a05_drop,
      input$a06_drop,
      input$a07_drop,
      input$a08_drop,
      input$a09_drop,
      input$b01_drop,
      input$b02_drop,
      input$b03_drop,
      input$b04_drop,
      input$b05_drop,
      input$b06_drop,
      input$b07_drop,
      input$b08_drop,
      input$b09_drop,
      input$c01_drop,
      input$c02_drop,
      input$c03_drop,
      input$c04_drop,
      input$c05_drop,
      input$c06_drop,
      input$c07_drop,
      input$c08_drop,
      input$c09_drop,
      input$d01_drop,
      input$d02_drop,
      input$d03_drop,
      input$d04_drop,
      input$d05_drop,
      input$d06_drop,
      input$d07_drop,
      input$d08_drop,
      input$d09_drop,
      input$e01_drop,
      input$e02_drop,
      input$e03_drop,
      input$e04_drop,
      input$e05_drop,
      input$e06_drop,
      input$e07_drop,
      input$e08_drop,
      input$e09_drop)
    },
    handlerExpr = {
      oldmat <- res$desirable
      input_static <- reactiveValuesToList(input)
      newmat <- make_newsort(cells = input_static,
                             emptymat = res$desirable)
      res$desirable <- update_sort(oldsort = oldmat, newsort = newmat)
      write.csv(x = res$desirable, file = "test.csv")
    }
  )

  output$text1 <- shiny::renderText({
    c(input$a01_drop,
      input$a02_drop,
      input$a03_drop,
      input$b01_drop)
    # "you have selected this."
  })
}

# Run the application
shinyApp(ui = ui, server = server)

