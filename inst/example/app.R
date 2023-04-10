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
            tags$h2("94 well plate picker"),
            WellPicker.shinyInput(
              "picker",
              rows = 8,
              columns = 12,
              wellSize = 30,
              disabled = c(0, 1, 2),
              renderText = JS("({index}) => { return index; }")
            ),
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
