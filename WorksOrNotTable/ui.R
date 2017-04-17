# Goals: maek it easier to test
# Some ideas: display table of original app, comments section
# store to csv button
#
library(shiny)
library(DT)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("Test Shiny Apps manually"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      helpText("This app uses modified shiny based on Bootstrap v4",
               "Click to save comments that you have provided.",
               "This will save new data in csv for long-term storage.",
               "(To be used later - waiting on DT functionality)"),
      hr(),
      actionButton("save", "Save comments")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      DT::dataTableOutput('testingMatrix')
    )
  )
))
