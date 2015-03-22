StockAnalysis
========================================================
author: Siva S.
date: Sunday, March 22, 2015

Overview
========================================================


Here we are looking at a app that pull stock prices by ticker symbol and displays the results as a line chart. The app lets you

* Select a stock to examine
* Pick a range of dates to review
* Choose whether to plot stock prices or the log of the stock prices on the y axis, and
* Let you to select VOLUME for the date selected.
* Let you to select SIMPLE MOVING AVERAGE for the date selected.
* Similarly any other can also be added to the selection.

ui.R Code - high level review
========================================================


```r
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
```

<!--html_preserve--><div class="container-fluid">
<h2>Dynamic Stock Chart</h2>
<div class="row">
<div class="col-sm-4">
<form class="well">
<span class="help-block">Select a FIRST stock to examine. 
        Information will be collected from yahoo finance.</span>
<div class="form-group shiny-input-container">
<label for="symb">Symbol</label>
<input id="symb" type="text" class="form-control" value="SPY"/>
</div>
<div id="dates" class="shiny-date-range-input form-group shiny-input-container">
<label class="control-label" for="dates">Date range</label>
<div class="input-daterange input-group">
<input class="input-sm form-control" type="text" data-date-language="en" data-date-weekstart="0" data-date-format="yyyy-mm-dd" data-date-start-view="month" data-initial-date="2013-01-01"/>
<span class="input-group-addon"> to </span>
<input class="input-sm form-control" type="text" data-date-language="en" data-date-weekstart="0" data-date-format="yyyy-mm-dd" data-date-start-view="month" data-initial-date="2015-03-22"/>
</div>
</div>
<button id="get" type="button" class="btn btn-default action-button">Get Stock</button>
<br/>
<br/>
<span class="help-block">Following features are enabled</span>
<div class="form-group shiny-input-container">
<div class="checkbox">
<label>
<input id="vol" type="checkbox"/>
<span>Add Volume</span>
</label>
</div>
</div>
<div class="form-group shiny-input-container">
<div class="checkbox">
<label>
<input id="mva" type="checkbox"/>
<span>Simple Moving Average</span>
</label>
</div>
</div>
</form>
</div>
<div class="col-sm-8">
<div id="plot" class="shiny-plot-output" style="width: 100% ; height: 400px"></div>
</div>
</div>
</div><!--/html_preserve-->

server.R - High level code review
========================================================

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


Conclusion
========================================================

The Stock Chart is dynamic and more parameters can be added without any much efforts. Its does support around 20 variables that are part of QUANTMOD package which will help in doing any kind of stock analysis.
