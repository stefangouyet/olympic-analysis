library(shiny)
library(dplyr)
library(ggplot2)
library(shinythemes)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  theme = shinytheme("simplex"),
  
  # Application title
  titlePanel("A Multi-Level Analysis of Olympians"),
  
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput("medal_color", 
                         "Choose one or more medal colors",
                         choices = c("Gold","Silver","Bronze","All")),
      selectInput("cumulativeness","Cumulative or not?",
                         choices = c("Cumulative" = "cum_wins",
                                     "Not Cumulative" = "n"),
                  selected = "Cumulative"),
      sliderInput("olympic_year",
                  "Year",
                  min = 1896, 
                  max = 2016,
                  value=c(1988,2000),
                  step = 2, 
                  sep = "",
                  animate = TRUE),
                         
      actionButton(inputId = "update",label = "Update"))
    ,
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot")
    )
  )
))
