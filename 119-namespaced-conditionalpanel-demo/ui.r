myPlotUI <- function(id, label = "My Plot") {
  ns <<- NS(id)
  tagList(
    column(4, cardPanel(
      sliderInput(
        ns("n"),
        "Number of points:",
        min = 10,
        max = 200,
        value = 50,
        step = 10
      )
    )),

    column(
      5,
      tags$h2(label),
      "The plot below will be not displayed when the slider value",
      "is less than 50.",

      # With the conditionalPanel, the condition is a JavaScript
      # expression. In these expressions, input values like
      # input$n are accessed with dots, as in input.n
      conditionalPanel("input.n >= 50",
                       ## The condition is namespaced to this particular
                       ## instance of this module by providing the ns parameter.
                       ## Consequently, input.n refers to this module's input
                       ## named n, and no other.
                       ns = ns,
                       plotOutput(ns("scatterPlot"), height = 300))
    )
  )
}

ui <- fluidPage(
  titlePanel("Namespaced conditional panels"),
  myPlotUI("plot1", label = "My first plot"),
  myPlotUI("plot2", label = "My second plot")
)
