library(shiny)
library(DT)

saveData <- function(data) {
  data <- as.data.frame(t(data))

  # Write the file to the local system
  write.csv(
    x = responses,
    file = file.path(outputDir, responses),
    row.names = FALSE, quote = TRUE
  )
}

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

  output$testingMatrix <- renderDataTable({
    readCSVDATA <- read.csv(file="data.csv", header=TRUE, sep=";")
    readCSVDATA$originalLink <- paste0("<a href='",
      readCSVDATA$originalLink, "' target='_blank'", ">", readCSVDATA$originalLink, "</a>")

    readCSVDATA$testingLink <- paste0("<a href='",
      readCSVDATA$testingLink, "' target='_blank'", ">", readCSVDATA$testingLink, "</a>")

    datatable(readCSVDATA, extensions = 'ColReorder',
              colnames = c(ID = 1), escape = FALSE,
              options = list(pageLength = 120, colReorder = TRUE)
              )
  })

  # Whenever a field is filled, aggregate all form data
  formData <- reactive({
    data <- sapply(fields, function(x) input[[x]])
    data
  })

  # When the Save button is clicked, save the form data
  observeEvent(input$save, {
    saveData(formData())
  })

})
