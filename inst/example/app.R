library(shiny)
library(shiny.react)
library(shiny.wellplates)

ui <- fluidPage(

    titlePanel("Shiny Well Plates Example"),
    fluidRow(
        column(width = 6,
            tags$h2("384 well plate (only display)"),
            WellPlate(
              rows = 16,
              columns = 24,
              wellSize = 20,
              renderText = JS("() => { return null; }")
            )
        ),
        column(width = 6,
            tags$h2("96 well plate picker"),
            ColorfullWellPicker(
              "picker",
              rows = 8,
              columns = 12,
              colors = rep(RColorBrewer::brewer.pal(n = 8, "Pastel1"), each=12)
            ),
            tags$h2("selected well indexes"),
            verbatimTextOutput("selectedWellIndexes")
        )
    )
)

server <- function(input, output) {
    output$selectedWellIndexes <- renderPrint({
        input$picker
    })
}

# Run the application
shinyApp(ui = ui, server = server)
