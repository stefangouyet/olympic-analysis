library(shiny)
library(dplyr)
library(ggplot2)
library(shinythemes)

df <- df <- read.csv("athlete_events.csv")

df1 <- df %>% group_by(NOC,Year,Season,Medal) %>% 
  count() %>%
  group_by(NOC,Medal) %>%
  arrange(Year, Season) %>%
  mutate(cum_wins = cumsum(n))

country_list <- c("")

df1 <- df %>% filter()


shinyServer(function(input, output) {
  
  observeEvent(input$update,{
    

  output$distPlot <- renderPlot({
    
    Gold      <- "Gold"   %in% input$medal_color
    Silver    <- "Silver" %in% input$medal_color
    Bronze    <- "Bronze" %in% input$medal_color
    
    if (Gold & Silver & Bronze){
      updated_data <- df1 %>% filter(Medal %in% c("Gold","Bronze","Silver")) 
    } else if (Gold & Silver){
      updated_data <- df1 %>% filter(Medal %in% c("Gold","Silver"))
    } else if (Gold & Bronze){
      updated_data <- df1 %>% filter(Medal %in% c("Gold","Bronze"))
    } else if (Silver & Bronze){
      updated_data <- df1 %>% filter(Medal %in% c("Bronze","Silver"))
    } else if (Silver){
      updated_data <- df1 %>% filter(Medal %in% c("Silver"))
    } else if (Bronze){
      updated_data <- df1 %>% filter(Medal %in% c("Bronze"))
    } else if (Gold){
      updated_data <- df1 %>% filter(Medal %in% c("Gold"))
    }
    
    #pick teams with over 50 all-time wins
    if (input$cumulativeness == "Cumulative"){
      updated_data <- updated_data %>% filter(NOC %in% c("ARG", "AUS","BEL","BRA", "CAN", "CHN",
"CRO", "CUB", "DEN", "ESP", "FRA", "GBR", "GER", "GRE", "HUN", "ITA", "JPN", "KOR", "NED", "NZL",
"POL", "ROU", "RUS", "SUI", "SWE", "USA"))
    }
    
    updated_data <- updated_data %>% filter(Year > input$olympic_year[[1]] & 
                                              Year < input$olympic_year[[2]])
    
    
    
    updated_data %>% ggplot(aes(x = NOC,
                                y = input$cumulativeness)) + 
      geom_bar(stat = "identity", color = "blue") +
      labs(x = "Country", y = "Medals")
      
    
    
  })
  
  })
})
