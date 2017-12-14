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
  rintrojs::introjsUI(),

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
            radioButtons(
              inputId = "type",
              label = "Item Type",
              choices = list(Text = "text", Images = "image"),
              selected = "text",
              inline = TRUE
            ),
            radioButtons(
              inputId = "markup",
              label = "Markup",
              choices = list('Plain Text' = "plain"),
              selected = "plain"
            )
          ),
          box(
            title = "Languages",
            selectizeInput(
              inputId = "languages-babel",
              label = NULL,
              choices = pensieve:::latex$options$babel,
              options = list(
                maxItems = 100
              )
            ),
            checkboxInput(
              inputId = "babel",
              label = "Language(s) are Babel Languages",
              value = TRUE
            ),
            footer = "For text items, select valid Babel languages for enhanced typesetting."
          ),
          box(
            fileInput(
              inputId = "concourse",
              label = "Upload",
              multiple = FALSE,
              accept = c(
                "text/csv"
              )
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
