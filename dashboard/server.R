library("dplyr")
library("ggplot2")
library("scales")
library("Hmisc")
library(shinydashboard)
source('data.R', local = TRUE)

server <- function(input, output) {
  set.seed(122)
  data <- getData()
  
  # checkboxes ------------------------------------------------------------------------------------
  
  categories = unique(data$main_category);
  print(categories)
  components = list()
  for (i in 1:length(categories)){
    inputId = paste0("chk_", i)
    print(inputId)
    components[[i]] <- checkboxInput(inputId, categories[[i]], value = TRUE, width = NULL)
  }
  print(components)
  
  output$checkboxes <- renderUI(components)
  
  # plot 1 ----------------------------------------------------------------------------------------
  
  data %>%
    group_by(main_category) %>%
    summarise(sucessfull = sum(state == "successful"),
              failed = sum(state == "failed"),
              canceled = sum(state == "canceled"),
              success_rate = round(sum(state == "successful") / n(), digits = 2),
              failed_rate = round(sum(state == "failed") / n(), digits = 2),
              canceled_rate = round(sum(state == "canceled") / n(), digits = 2))
  
  plot1 <- data %>%
    group_by(main_category, state) %>%
    summarise(count = n()) %>%
    mutate(percentage = count / sum(count), label = scales::percent(percentage))
  
  output$plot1 <- renderPlot({
    ggplot(plot1, aes(x = factor(main_category, levels = levels(plot1$main_category)), 
                      y = percentage,
                      fill = factor(state, levels = levels(plot1$state)))) +
      geom_bar(stat = "identity", position = "fill") + 
      scale_y_continuous(breaks = seq(0, 1, 0.2), labels = paste(seq(0, 100, 20), "%", sep = "")) +
      geom_text(aes(label = label), size = 3, position = position_stack(vjust = 0.5)) +
      scale_fill_manual(values = c("successful" = "green", "failed" = "red", "canceled" = "blue")) +
      labs(y = "Percent", fill = "State", x = "Category", title = "Project state by category") +
      theme(axis.text.x = element_text(angle = 290, hjust = 0, vjust = 0.5))
  })
  
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