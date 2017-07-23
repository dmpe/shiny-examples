library(shiny)



myPlot <- function(input, output, session, deviates) {
  output$scatterPlot <- renderPlot({
    x <- rnorm(input$n)
    y <- rnorm(input$n)
    plot(x, y)
  })
}

server <- function(input, output) {
  callModule(myPlot, "plot1")
  callModule(myPlot, "plot2")
}



