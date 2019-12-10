library("dplyr")
library("ggplot2")
library("scales")
library("Hmisc")
library(shinydashboard)
source('data.R', local = TRUE)

server <- function(input, output) {
  set.seed(122)
  data <- getData()
  
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
  
  data %>%
    mutate(year = as.integer(format(launched, "%Y"))) %>%
    group_by(year) %>%
    summarise(sucessfull = sum(state == "successful"),
              failed = sum(state == "failed"),
              canceled = sum(state == "canceled"),
              success_rate = round(sum(state == "successful") / n(), digits = 2),
              failed_rate = round(sum(state == "failed") / n(), digits = 2),
              canceled_rate = round(sum(state == "canceled") / n(), digits = 2)) %>%
    arrange(year)
  
  plot2 <- data %>%
    mutate(year = as.integer(format(launched, "%Y"))) %>%
    group_by(year, state) %>%
    summarise(count = n()) %>%
    mutate(percentage = count / sum(count), label = scales::percent(percentage)) %>%
    arrange(year)
  
  output$plot2 <- renderPlot({
    ggplot(plot2, aes(x = year, y = percentage)) +
      geom_line(aes(color = state)) + 
      scale_color_manual(values = c("successful" = "green", "failed" = "red", "canceled"="blue")) + 
      scale_y_continuous(breaks = seq(0, 1, 0.2), labels = paste(seq(0, 100, 20), "%", sep = "")) +
      labs(y = "Percent", fill = "State", x = "Year", title = "Project state by year") + 
      theme_minimal()
  })
  
  # plot 3 ----------------------------------------------------------------------------------------
    
  data %>%
    mutate(month = as.integer(format(launched, "%m"))) %>%
    group_by(month) %>%
    summarise(sucessfull = sum(state == "successful"),
              failed = sum(state == "failed"),
              canceled = sum(state == "canceled"),
              success_rate = round(sum(state == "successful") / n(), digits = 2),
              failed_rate = round(sum(state == "failed") / n(), digits = 2),
              canceled_rate = round(sum(state == "canceled") / n(), digits = 2)) %>%
    arrange(month)

  plot3 <- data %>%
    mutate(month = as.integer(format(launched, "%m"))) %>%
    group_by(month, state) %>%
    summarise(count = n()) %>%
    mutate(percentage = count / sum(count), label = scales::percent(percentage)) %>%
    arrange(month)
  
  output$plot3 <- renderPlot({
    ggplot(plot3, aes(x = month, y = percentage)) +
      geom_line(aes(color = state)) + 
      scale_color_manual(values = c("successful" = "green", "failed" = "red", "canceled" = "blue")) + 
      scale_y_continuous(breaks = seq(0, 1, 0.2), labels = paste(seq(0, 100, 20), "%", sep = "")) +
      labs(y = "Percent", fill = "State", x = "Month", title = "Project state by month") + 
      theme_minimal()
  })
  
  # plot 4 ----------------------------------------------------------------------------------------
  
  output$plot4 <- renderPlot({
    ggplot(data, aes(x = main_category, y = goal, fill = state)) +
      geom_boxplot() + 
      labs(fill = "Goal") + 
      labs(y = "goal", fill = "state", x = "category", title = "Goal amount by category and state") + 
      theme(axis.text.x = element_text(angle = 290, hjust = 0, vjust = 0.5))
  })
  
  # plot 5 ----------------------------------------------------------------------------------------

  output$plot5 <- renderPlot({
    ggplot(data, aes(x = main_category, y = pledged, fill = state)) +
      geom_boxplot() + 
      labs(fill = "Pledged") + 
      labs(y = "pledged", fill = "state", x = "category", title = "Pledged amount by category and state") + 
      theme(axis.text.x = element_text(angle = 290, hjust = 0, vjust = 0.5))
  })
}