# server.R

library(quantmod)
source("helpers.R")

shinyServer(function(input, output) {

  output$plot <- renderPlot({
    data <- getSymbols(input$symb, src = "yahoo", 
      from = input$dates[1],
      to = input$dates[2],
      auto.assign = FALSE)
    
    
    #TAList <- "addVo();addBBands();addCCI();addSAR()"
    

    chartSeries(data, theme = chartTheme("white"), 
      type = "line", TA = NULL)
    
    if(input$vol==TRUE){chartSeries(data, theme = chartTheme("white"), 
                                    type = "line", TA = "addVo()")}
    if(input$mva==TRUE){chartSeries(data, theme = chartTheme("white"), 
                                    type = "line", TA = "addSMA()")}
          
      

  })
})
