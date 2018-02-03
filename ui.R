library(pensieve)
source("helpers.R")
library(shiny)
library(shinydashboard)
library(shinyjs)

# header ====
header <- dashboardHeader(
  title = span(img(src = "logo.png", height = 40), "accio pensieve")
)

# sidebar ====
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(
      text = "Study",
      badgeLabel = "Demo",
      badgeColor = "purple",
      tabName = "study",
      icon = icon(name = "cloud-upload", lib = "font-awesome")
    ),
    menuItem(
      text = "Items",
      tabName = "items",
      icon = icon("file-text-o"),
      menuItem(
        text = "Foo",
        badgeLabel = "zap",
        icon = icon("file-text-o")
      ),
      menuSubItem(
        text = "Concourse",
        tabName = "concourse",
        icon = icon("edit")
      )
    ),
    menuItem("People", tabName = "people", icon = icon("dashboard"))
  )
)

# body ====
body <- dashboardBody(
  shinyjs::useShinyjs(),  # odd but proper place to call this

  # study
  tabItems(
    tabItem(
      tabName = "study",

      fluidRow(
        box(
          title = "Study",
          footer = md("If you load a study, **all unsaved changes will be lost.**"),
          radioButtons(
            inputId = "source",
            label = "Select source",
            choices = c(Demo = "demo", New = "new", Upload = "upload"),
            selected = "demo",
            inline = TRUE
          ),
          conditionalPanel(
            condition = "input.source == 'demo'",
            selectizeInput(
              inputId = "Study",
              label = "Demo Study",
              selected = "brown1980",
              multiple = FALSE,
              choices = c(
                'Brown 1980' = "brown1980",
                'Pfeiffer Held 2016' = "pfeifferetal2016"
              ),
              options = list(
                create = FALSE,
                createOnBlur = TRUE,
                highlight = TRUE,
                persist = FALSE,
                openOnFocus = TRUE,
                closeAfterSelect = TRUE
              )
            )
          ),
          conditionalPanel(
            condition = "input.source == 'new'",
            textInput(
              inputId = "new-name",
              label = "Study Name",
              value = "",
              placeholder = "Add a short file name for your new study."
            )
          ),
          conditionalPanel(
            condition = "input.source == 'upload'",
            fileInput(
              inputId = "rdata",
              label = md("Upload a `*.rdata` file created by *pensieve*."),
              multiple = FALSE,
              placeholder =
                "Only for `.rdata` files previously exported from pensieve."
            ),
            md("To upload your own raw data not touched by *pensieve*, select 'New' and continue in the app.")
          ),
          actionButton(
            inputId = "load-study",
            label = "Load",
            icon = NULL,
            width = '100%'
          )
        )
      )
    ),

    tabItem(
      tabName = "items",
      h2("Items stuff")
    ),

      tabItem(
        tabName = "concourse",
        h2("Concourse of Full Items"),

        fluidRow(
          box(
            title = "Options",
            width = 6,
            radioButtons(
              inputId = "type",
              label = "Item Type",
              choices = list(
                Text = "text"
                # Images = "image"
              ),
              selected = "text",
              inline = TRUE
            ),
            radioButtons(
              inputId = "markup",
              label = "Markup Language",
              choices = list('Plain Text' = "plain"),
              selected = "plain"
            ),
            selectizeInput(
              inputId = "languages_babel",
              label = "Item Language(s)",
              choices = pensieve:::latex$options$babel,
              multiple = TRUE,
              selected = c("english", "ngerman"),
              options = list(placeholder = "Select one or more languages.")
            ),
            textInput(
              inputId = "languages_any",
              label = "Item Language(s)",
              value = "klingon, elvish",
              placeholder = "Enter one or more languages, separated by commas."
            ),
            tags$div(
              "For text items, select valid",
              tags$a(href = "https://ctan.org/pkg/babel", "Babel"),
              "languages for enhanced typesetting."
            ),
            checkboxInput(
              inputId = "babel",
              label = "Language(s) are Babel Languages",
              value = TRUE
            )
          ),
          box(
            title = "Upload",
            width = 6,
            checkboxInput(
              inputId = "header",
              label = "File includes first row with language names (will be ignored).",
              value = TRUE
            ),
            radioButtons(
              inputId = "sep",
              label = "Separate items by",
              inline = TRUE,
              choices = c(Comma = ",", Semicolon = ";"),
              selected = ","
            ),
            tags$hr(),
            tags$div(
              "Use Microsoft Excel or another spreadsheet program to create and export a comma-separated-values (CSV) file of full items.",
              "The resulting CSV file should look like this:"
            ),
            verbatimTextOutput(outputId = "example"),
            tags$hr(),
            shiny::fileInput(
              inputId = "file",
              label = "CSV file",
              multiple = FALSE,
              accept = c(
                "text/csv",
                "text/comma-separated-values,text/plain",
                ".csv"
              ),
              placeholder = "Choose a file from your computer."
              )
          )
        )
      ),

    tabItem(
      tabName = "people",
      h2("Other stuff")
    )
  )
)

dashboardPage(
  skin = "purple",
  header = header,
  sidebar = sidebar,
  body = body,
  title = "accio pensieve"
)
