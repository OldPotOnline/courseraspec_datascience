library(shiny)

shinyUI(
  pageWithSidebar(
    headerPanel("Different Distribution Study"),
    
    sidebarPanel(
                 selectInput("Distribution", "Please Select Distribution Type",
                             choices=c("Normal", "Exponential", "Geometric", "Binomial")),
                 sliderInput("sampleSize", "Please Select Sample Size: ",
                             min=100, max=5000, value=1000, step=100),
                 sliderInput("numOfBins", "Please Select Number of Bins", min=10, max=1000, value=100, step=5),
                 conditionalPanel(condition = "input.Distribution == 'Normal'",
                                  numericInput("mean", "Pleasee Select the Mean", 10),
                                  numericInput("sd", "Please Select Standard Deviation", 3)),
                 conditionalPanel(condition = "input.Distribution == 'Exponential'",
                                  numericInput("lambda", "Please Select Exponential Lambda: ", 1)),
                 conditionalPanel(condition = "input.Distribution == 'Geometric'",
                                  numericInput("prob", "Please Select Geometric Prob: ", 0.5, step=0.02)),
                 conditionalPanel(condition = "input.Distribution == 'Binomial'",
                                  numericInput("x", "Please Select Binomial x: ", 4, step=1),
                                  numericInput("prob", "Please Select Binomial Prob: ", 0.5, step=0.02))
                 ),
    
    mainPanel(
        plotOutput("distriPlot")
      )
    
  )
  
)