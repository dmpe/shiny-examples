library(knitr)
library(rmarkdown)
library(shinyV4)
# http://shiny.leg.ufpr.br/daniel/020-knit-html/


options(display.mode = "showcase")

ui <- fluidPage(title = 'Embed an HTML report from R Markdown/knitr',
            sidebarLayout(
              sidebarPanel(
                withMathJax(),
                # include the MathJax library
                selectInput('x', 'Build a regression model of mpg against:',
                            choices = names(mtcars)[-1])
              ),
              mainPanel(uiOutput('report'))
            )
)

ser <- function(input, output) {
  regFormula <- reactive({
    as.formula(paste('mpg ~', input$x))
  })

  output$report <- renderUI({
    src <- normalizePath('report.Rmd')

    # temporarily switch to the temp dir, in case you do not have write
    # permission to the current working directory
    owd <- setwd(tempdir())
    on.exit(setwd(owd))
    knitr::opts_knit$set(root.dir = owd)

    tagList(HTML(knitr::knit2html(
      text = readLines(src), fragment.only = TRUE
    )),
    # typeset LaTeX math
    tags$script(HTML(
      'MathJax.Hub.Queue(["Typeset", MathJax.Hub]);'
    )),
    # syntax highlighting
    tags$script(
      HTML(
        "if (hljs) $('#report pre code').each(function(i, e) {
        hljs.highlightBlock(e) });"
    )
      ))
  })

}


shinyApp(ui = ui, server = ser)

runApp(display.mode = "showcase")
