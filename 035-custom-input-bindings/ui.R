source("url-input.R")

fluidPage(
  titlePanel("Custom input example"),

  fluidRow(
    column(4, cardPanel(
      urlInput("my_url", "URL: ", "http://www.r-project.org/"),
      actionButton("reset", "Reset URL")
    )),
    column(8, cardPanel(
      verbatimTextOutput("urlText")
    ))
  )
)
