basicPage(
  plotOutput('plot', width = "300px", height = "300px"),
  tableOutput('table'),
  radioButtons('style', 'Progress bar style', 'notification'),
  actionButton('goPlot', 'Go plot'),
  actionButton('goTable', 'Go table')
)
