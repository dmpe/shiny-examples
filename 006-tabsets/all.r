library(shinyV4)

app <- shinyApp(qwed <- function(input, output) {
  data <- reactive({
    dist <- switch(
      input$dist,
      norm = rnorm,
      unif = runif,
      lnorm = rlnorm,
      exp = rexp,
      rnorm
    )

    dist(input$n)
  })

  output$plot <- renderPlot({
    dist <- input$dist
    n <- input$n

    hist(data(),
         main = paste('r', dist, '(', n, ')', sep = ''))
  })

  # Generate a summary of the data
  output$summary <- renderPrint({
    summary(data())
  })

  # Generate an HTML table view of the data
  output$table <- renderTable({
    data.frame(x = data())
  })

},

pl <- fluidPage(
  # Application title
  titlePanel("Tabsets"),

  # Sidebar with controls to select the random distribution type
  # and number of observations to generate. Note the use of the
  # br() element to introduce extra vertical spacing
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        "dist",
        "Distribution type:",
        c(
          "Normal" = "norm",
          "Uniform" = "unif",
          "Log-normal" = "lnorm",
          "Exponential" = "exp"
        )
      ),
      br(),

      sliderInput(
        "n",
        "Number of observations:",
        value = 500,
        min = 1,
        max = 1000
      )
    ),

    # Show a tabset that includes a plot, summary, and table view
    # of the generated distribution
    mainPanel(tabsetPanel(
      type = "tabs",
      tabPanel("Plot", plotOutput("plot")),
      tabPanel("Summary", verbatimTextOutput("summary")),
      tabPanel("Table", tableOutput("table"))
    ))
  )
))



runApp(display.mode = "showcase")
