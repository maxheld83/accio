library(pensieve)
library(shiny)
library(shinydashboard)
library(shinyjs)

header <- dashboardHeader(
  title = span(img(src = "logo.png", height = 40), "accio pensieve")
)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(
      text = "Items",
      tabName = "items",
      icon = icon("file-text-o"),
      menuSubItem(
        text = "Concourse",
        tabName = "concourse",
        icon = icon("edit")
      )
    ),
    menuItem("People", tabName = "people", icon = icon("dashboard"))
  )
)

body <- dashboardBody(
  shinyjs::useShinyjs(),  # odd but proper place to call this

  tabItems(
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
              label = "Markup",
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
              value = "klingon, elvish"
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
            title = "Upload CSV File",
            width = 6,
            # Input: Checkbox if file has header
            checkboxInput(
              inputId = "header",
              label = "Ignore first row (may include language names for easier editing).",
              value = TRUE
            ),
            radioButtons(
              inputId = "quote",
              label = "Place each item in",
              choices = c('Double Quotes' = '"', 'Single Quotes' = "'"),
              selected = '"',
              inline = TRUE
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
              "A comma-separated-values (CSV) file can be easily created and exported from Microsoft Excel or other spreadsheet programs.",
              "Please make sure your CSV file looks like this:"
            ),
            tags$pre("foo")
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
