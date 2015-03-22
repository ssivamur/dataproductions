library(shiny)

shinyUI(fluidPage(
  titlePanel("Dynamic Stock Chart"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Select a FIRST stock to examine. 
        Information will be collected from yahoo finance."),
    
      textInput("symb", "Symbol", "SPY"),
      
      dateRangeInput("dates", 
        "Date range",
        start = "2013-01-01", 
        end = as.character(Sys.Date())),
   
      actionButton("get", "Get Stock"),
      
      br(),
      br(),
      
      helpText("Following features are enabled"),
      
      checkboxInput("vol", "Add Volume", value=FALSE),
      checkboxInput("mva", "Simple Moving Average", value=FALSE)
    ),
    
    mainPanel(plotOutput("plot"))
  )
))