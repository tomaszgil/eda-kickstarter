library("dplyr")
library("ggplot2")
library("scales")
library("Hmisc")
library(shinydashboard)
source('data.R', local = TRUE)



server <- function(input, output) {
  set.seed(122)
  data <- getData()
  
  print(data)
  
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
}