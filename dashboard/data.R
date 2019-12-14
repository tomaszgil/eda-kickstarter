library("dplyr")
library("ggplot2")
library("scales")
library("Hmisc")

is.date <- function(x) !is.na(as.Date(x, format="%Y-%m-%d"))

getData <- function() {
  data <- read.csv(file="../data/ks-projects.csv", header=TRUE, sep=",")
  
  data <- data %>% 
    select(4:11) %>% 
    select(-2)
  data <- data[, c(1, 3, 5, 7, 6, 4, 2)]
  
  categoryFrequency <- as.list(table(data$main_category))
  data <- data %>% 
    filter(categoryFrequency[main_category] > 100)
  
  data <- data %>% 
    filter(is.date(deadline) & is.date(launched)) %>%
    filter(format(as.Date(launched), "%Y") > 2000)
  
  data <- data %>% 
    filter(state == "canceled" | 
             state == "failed" |
             state == "successful")
  
  data <- data %>%
    filter(!is.na(as.double(as.character(goal))))
  
  data <- data %>%
    filter(!is.na(as.double(as.character(pledged))))
  
  data <- data %>%
    filter(!is.na(as.integer(as.character(backers))))
  
  data$main_category <- as.factor(data$main_category)
  data$goal <- as.double(data$goal)
  data$deadline <- as.Date(data$deadline)
  data$launched <- as.Date(data$launched)
  data$pledged <- as.double(data$pledged)
  data$backers <- as.double(data$backers)
  
  return(data)
}