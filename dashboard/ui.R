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
    h3("Categories"),
    checkboxInput("check1", "Art", value = TRUE, width = NULL),
    checkboxInput("check2", "Comics", value = TRUE, width = NULL),
    checkboxInput("check3", "Crafts", value = TRUE, width = NULL),
    checkboxInput("check4", "Dance", value = TRUE, width = NULL),
    checkboxInput("check5", "Design", value = TRUE, width = NULL),
    checkboxInput("check6", "Fashion", value = TRUE, width = NULL),
    checkboxInput("check7", "Film & video", value = TRUE, width = NULL),
    checkboxInput("check8", "Food", value = TRUE, width = NULL),
    checkboxInput("check9", "Games", value = TRUE, width = NULL),
    checkboxInput("check10", "Journalism", value = TRUE, width = NULL),
    checkboxInput("check11", "Music", value = TRUE, width = NULL),
    checkboxInput("check12", "Philosophy", value = TRUE, width = NULL),
    checkboxInput("check13", "Publishing", value = TRUE, width = NULL),
    checkboxInput("check14", "Technology", value = TRUE, width = NULL),
    checkboxInput("check15", "Theater", value = TRUE, width = NULL)
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "t1",
              box(plotOutput("plot1", height = 800), width = "100%")
      ),
      tabItem(tabName = "t2",
              box(plotOutput("plot2", height = 800), width = "100%")
      ),
      tabItem(tabName = "t3",
              box(plotOutput("plot3", height = 800), width = "100%")
      ),
      tabItem(tabName = "t4",
              box(plotOutput("plot4", height = 800), width = "100%")
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