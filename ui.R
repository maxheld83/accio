library(pensieve)
library(rhandsontable)
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

df <- data.frame(english = c("foo", "bar"),
                 german = c("zap", "zop"))

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
            footer = "For text items, select valid Babel languages for enhanced typesetting.",
            width = 12,
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
            ),
            checkboxInput(
              inputId = "babel",
              label = "Language(s) are Babel Languages",
              value = TRUE
            ),
            selectizeInput(
              inputId = "languages-babel",
              label = "Item Language(s)",
              choices = pensieve:::latex$options$babel,
              multiple = TRUE,
              options = list(placeholder = "Select one or more languages.")
            ),
            textInput(
              inputId = "languages-any",
              label = "Item Language(s)",
              value = "english, german"
            )
          ),
          box(
            title = "Enter and Edit",
            width = 12,
            rhandsontable::rhandsontable(data = df)
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
