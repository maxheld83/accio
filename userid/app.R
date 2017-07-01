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


desirable <- matrix(data = NA,
                    nrow = 5,
                    ncol = 9,
                    dimnames = list(rows = c("a", "b", "c", "d", "e"),
                                    columns = c("01", "02", "03", "04", "05", "06", "07", "08", "09")))


make_newsort <- function(cells, emptymat) {
  # emptymat <- desirable
  # cells <- list(b02_drop = "foo", a03_drop = "bar", e09_drop = "lirum")
  # set all to NA
  emptymat[,] <- NA
  newmat <- emptymat
  for (row_i in rownames(emptymat)) {
    for (col_i in 1:ncol(emptymat)) {
      thisel <- paste0(row_i, "0", col_i, "_", "drop")
      if (!is.null(cells[[thisel]])) {
        newmat[row_i, col_i] <- cells[[thisel]]
      }
    }
  }
  return(newmat)
}

# test_oldmat <- structure(c(NA, NA, NA, NA, NA, NA, "foo", NA, NA, NA, "bar",
#                            NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
#                            NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
#                            NA, "lirum"), .Dim = c(5L, 9L), .Dimnames = structure(list(rows = c("a",
#                                                                                                "b", "c", "d", "e"), columns = c("01", "02", "03", "04", "05",
#                                                                                                                                 "06", "07", "08", "09")), .Names = c("rows", "columns")))
# test_newmat <- structure(c(NA, NA, NA, NA, NA, NA, "foo", NA, NA, NA, "bar",
#                            NA, NA, NA, NA, NA, NA, "foo", NA, NA, NA, NA, NA, NA, NA, NA, NA,
#                            NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA,
#                            NA, "lirum"), .Dim = c(5L, 9L), .Dimnames = structure(list(rows = c("a",
#                                                                                                "b", "c", "d", "e"), columns = c("01", "02", "03", "04", "05",
#                                                                                                                                 "06", "07", "08", "09")), .Names = c("rows", "columns")))

update_sort <- function(oldsort, newsort) {
  # newsort <- test_newmat
  # oldsort <- test_oldmat
  for (row_i in rownames(newsort)) {
    for (col_i in 1:ncol(newsort)) {
      current_item <- newsort[row_i, col_i]
      # current_item <- "as"
      # current_item <- "foo"
      if (sum(current_item == newsort, na.rm = TRUE) > 1) {
        newsort[which(oldsort == newsort & newsort == current_item, arr.ind = TRUE)] <- NA
      }
    }
  }
  return(newsort)
}


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

  res$desirable <- reactive({
    oldmat <- res$desirable
    write.csv(x = res$desirable, file = "oldmat.csv")
    input_static <- reactiveValuesToList(input)
    write_rds(input_static, path = "input_static.rds")
    newmat <- make_newsort(cells = input_static,
                           emptymat = res$desirable)
    write.csv(x = newmat, file = "newmat.csv")
    newmat2 <- update_sort(oldsort = oldmat, newsort = newmat)
    write.csv(x = newmat2, file = "newmat2.csv")
    return(newmat2)
  })

  # output$ <- renderTable(expr = res$desirable)
  #
  # observeEvent(eventExpr = res,
  #   handlerExpr = {
  #                write.csv(output, "outdes.csv")
  #              })

  # write.csv(x = newmat2, file = "newmat2.csv")
  # write.csv(x = res$desirable, file = "desirable.csv")

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

