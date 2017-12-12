library(shiny)
library(pensieve)
library(shinyBS)
library(shinydashboard)

header <- dashboardHeader(
  title = span(img(src = "logo.png", height = 40), "accio pensieve")
)

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Items", tabName = "items", icon = icon("file-text-o")),
    menuItem("People", tabName = "people", icon = icon("dashboard"))
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "items",
      h2("Items stuff")
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
