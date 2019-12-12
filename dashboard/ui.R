library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Plot 1", tabName = "t1", icon = icon("th")),
      menuItem("Plot 2", tabName = "t2", icon = icon("th")),
      menuItem("Plot 3", tabName = "t3", icon = icon("th")),
      menuItem("Plot 4", tabName = "t4", icon = icon("th")),
      menuItem("Raw data", tabName = "raw", icon = icon("th"))
    ),
    uiOutput("checkboxes")
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "t1",
              box(plotOutput("plot1", height = 450))
      ),
      tabItem(tabName = "t2",
              box(plotOutput("plot2", height = 450))
      ),
      tabItem(tabName = "t3",
              box(plotOutput("plot3", height = 450))
      ),
      tabItem(tabName = "t4",
              box(plotOutput("plot4", height = 450))
      ),
      tabItem(tabName = "raw",
              h2("Raw data"),
              numericInput("maxrows", "Rows to show", 25),
              verbatimTextOutput("rawtable"),
              downloadButton("downloadCsv", "Download as CSV")
      )
    )
  )
)