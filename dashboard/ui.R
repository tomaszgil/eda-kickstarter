library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Plot 1", tabName = "t1", icon = icon("th")),
      menuItem("Plot 2", tabName = "t2", icon = icon("th")),
      menuItem("Plot 3", tabName = "t3", icon = icon("th")),
      menuItem("Plot 4", tabName = "t4", icon = icon("th")),
      menuItem("Plot 5", tabName = "t5", icon = icon("th")),
      menuItem("Raw data", tabName = "raw", icon = icon("data"))
    ),
    sliderInput("slider", "Number of observations:", 1, 100, 50)
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "t1",
              fluidRow(
                box(plotOutput("plot1", height = 450))
              )
      ),
      tabItem(tabName = "t2",
              fluidRow(
                box(plotOutput("plot2", height = 450))
              )
      ),
      tabItem(tabName = "t3",
              fluidRow(
                box(plotOutput("plot3", height = 450))
              )
      ),
      tabItem(tabName = "t4",
              fluidRow(
                box(plotOutput("plot4", height = 450))
              )
      ),
      tabItem(tabName = "t5",
              fluidRow(
                box(plotOutput("plot5", height = 450))
              )
      ),
      tabItem(tabName = "raw",
              h2("Widgets tab content")
      )
    )
  )
)