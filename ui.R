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
  useShinyjs(),  # odd but proper place to call this

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
            ),
            checkboxInput(
              inputId = "babel",
              label = "Babel Language Support",
              value = TRUE
            )
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
