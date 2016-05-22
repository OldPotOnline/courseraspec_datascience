library(shiny)
library(ggplot2)

shinyServer(
    function(input, output, session) {
      output$distriPlot <- renderPlot({
        
          distType <- input$Distribution
          size <- input$sampleSize
          
          if(distType == "Normal" ) {
            randomVec <- rnorm(size, mean = input$mean, sd = input$sd)
          } else if(distType == "Exponential") {
            randomVec <- rexp(size, rate = 1/input$lambda)
          } else if(distType == "Geometric")  {
            randomVec <- rgeom(size, prob = input$prob)
          } else if(distType == "Binomial")  {
            randomVec <- dbinom(x=0:input$x, size, prob = input$prob)
          }
        
          hist(randomVec, col = "blue", breaks=input$numOfBins, main="Distribution Histogram")
      })
    }
  )