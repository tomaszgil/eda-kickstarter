library("dplyr")
library("ggplot2")
library("scales")
library("Hmisc")
library(shinydashboard)
source('data.R', local = TRUE)

server <- function(input, output) {
  set.seed(122)
  data <- getData()
  
  # filtering -------------------------------------------------------------------------------------
  
  categories <- reactive({
    categories <- c()
    if (input$check1) {
      categories <- c(categories, "Art")
    }
    if (input$check2) {
      categories <- c(categories, "Comics")
    }
    if (input$check3) {
      categories <- c(categories, "Crafts")
    }
    if (input$check4) {
      categories <- c(categories, "Dance")
    }
    if (input$check5) {
      categories <- c(categories, "Design")
    }
    if (input$check6) {
      categories <- c(categories, "Fashion")
    }
    if (input$check7) {
      categories <- c(categories, "Film & video")
    }
    if (input$check8) {
      categories <- c(categories, "Food")
    }
    if (input$check9) {
      categories <- c(categories, "Games")
    }
    if (input$check10) {
      categories <- c(categories, "Journalism")
    }
    if (input$check11) {
      categories <- c(categories, "Music")
    }
    if (input$check12) {
      categories <- c(categories, "Philosophy")
    }
    if (input$check13) {
      categories <- c(categories, "Publishing")
    }
    if (input$check14) {
      categories <- c(categories, "Technology")
    }
    if (input$check15) {
      categories <- c(categories, "Theater")
    }
    categories
  })
  
  data <- reactive({
    data[data$main_category %in% categories]
  })
  
  # plot 1 ----------------------------------------------------------------------------------------
  
  #plot1 <- data %>%
  #  group_by(main_category, state) %>%
  #  summarise(count = n()) %>%
  #  mutate(percentage = count / sum(count), label = scales::percent(percentage))
  #
  #output$plot1 <- renderPlot({
  #  ggplot(plot1, aes(x = factor(main_category, levels = levels(plot1$main_category)), 
  #                    y = percentage,
  #                    fill = factor(state, levels = levels(plot1$state)))) +
  #    geom_bar(stat = "identity", position = "fill") + 
  #    scale_y_continuous(breaks = seq(0, 1, 0.2), labels = paste(seq(0, 100, 20), "%", sep = "")) +
  #    geom_text(aes(label = label), size = 3, position = position_stack(vjust = 0.5)) +
  #    scale_fill_manual(values = c("successful" = "green", "failed" = "red", "canceled" = "blue")) +
  #    labs(y = "Percent", fill = "State", x = "Category", title = "Project state by category") +
  #    theme(axis.text.x = element_text(angle = 290, hjust = 0, vjust = 0.5))
  #})
  
  # plot 2 ----------------------------------------------------------------------------------------
  
  output$plot2 <- renderPlot({
    ggplot(data, aes(x = main_category, y = goal, fill = state)) +
      geom_boxplot() + 
      labs(fill = "Goal") + 
      labs(y = "goal", fill = "state", x = "category", title = "Goal amount by category and state") + 
      theme(axis.text.x = element_text(angle = 290, hjust = 0, vjust = 0.5))
  })
  
  # plot 3 ----------------------------------------------------------------------------------------

  output$plot3 <- renderPlot({
    ggplot(data, aes(x = main_category, y = pledged, fill = state)) +
      geom_boxplot() + 
      labs(fill = "Pledged") + 
      labs(y = "pledged", fill = "state", x = "category", title = "Pledged amount by category and state") + 
      theme(axis.text.x = element_text(angle = 290, hjust = 0, vjust = 0.5))
  })
  
  # plot 4 ----------------------------------------------------------------------------------------
  
  output$plot4 <- renderPlot({
    ggplot(data, aes(x = main_category, y = backers, fill = state)) +
      geom_boxplot() + 
      labs(fill = "Backers") + 
      labs(y = "Backers", fill = "state", x = "category", title = "Backers number by category and state") + 
      theme(axis.text.x = element_text(angle = 290, hjust = 0, vjust = 0.5))
  })
  
  # rawdata ---------------------------------------------------------------------------------------
  
  output$downloadCsv <- downloadHandler(
    filename = "kickstarter.csv",
    content = function(file) {
      write.csv(data, file)
    },
    contentType = "text/csv"
  )
  
  output$rawtable <- renderPrint({
    print(head(data, input$maxrows), row.names = FALSE)
  })
}