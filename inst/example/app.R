library(shiny)
library(shiny.react)
library(shiny.wellplates)

pallette <- RColorBrewer::brewer.pal(5, "Set2")

ui <- fluidPage(
  navbarPage(
    title = "Shiny Wellplates Example",
    id = "main_navbar",
    tabPanel(
      "WellPlate",
      sidebarLayout(
        sidebarPanel(
          width = 3,
          numericInput("wellplateRows", "Rows", value = 8, min = 1, max = 16, step = 1),
          numericInput("wellplateColumns", "Columns", value = 12, min = 1, max = 24, step = 1),
          checkboxInput("wellplateGrid", "Display as grid", value = FALSE),
          numericInput("wellplateSize", "Well size", value = 40, min = 10, max = 80, step = 10)
        ),
        mainPanel(
          width = 9,
          shiny.react::reactOutput("wellplate"),
        )
      )
    ),
    tabPanel(
      "WellPicker",
      sidebarLayout(
        sidebarPanel(
          width = 3,
          numericInput("wellpickerRows", "Rows", value = 8, min = 1, max = 16, step = 1),
          numericInput("wellpickerColumns", "Columns", value = 12, min = 1, max = 24, step = 1),
          checkboxInput("wellpickerGrid", "Display as grid", value = FALSE),
          numericInput("wellpickerSize", "Well size", value = 40, min = 10, max = 50, step = 10)
        ),
        mainPanel(
          width = 9,
          shiny.react::reactOutput("wellpicker"),
          tags$label("Selected well indexes"),
          verbatimTextOutput("wellpickerSelected")
        )
      )
    ),
    tabPanel(
      "ColorfullWellPicker",
      sidebarLayout(
        sidebarPanel(
          width = 3,
          numericInput("colorfullwellpickerRows", "Rows", value = 8, min = 1, max = 16, step = 1),
          numericInput("colorfullwellpickerColumns", "Columns", value = 12, min = 1, max = 24, step = 1),
          checkboxInput("colorfullwellpickerGrid", "Display as grid", value = FALSE),
          numericInput("colorfullwellpickerSize", "Well size", value = 40, min = 10, max = 50, step = 10)
        ),
        mainPanel(
          width = 9,
          tags$p(tags$label("Click a button to change or clear color of selected well.")),
          actionButton("colorfullwellpickerA", "A", style = sprintf("background-color: %s", pallette[1])),
          actionButton("colorfullwellpickerB", "B", style = sprintf("background-color: %s", pallette[2])),
          actionButton("colorfullwellpickerC", "C", style = sprintf("background-color: %s", pallette[3])),
          actionButton("colorfullwellpickerD", "D", style = sprintf("background-color: %s", pallette[4])),
          actionButton("colorfullwellpickerE", "E", style = sprintf("background-color: %s", pallette[5])),
          actionButton("colorfullwellpickerClear", "Clear"),
          shiny.react::reactOutput("colorfullwellpicker"),
        )
      )
    )
  )
)

server <- function(input, output, session) {
  output$wellplate <- shiny.react::renderReact({
    WellPlate(
      rows = input$wellplateRows,
      columns = input$wellplateColumns,
      displayAsGrid = input$wellplateGrid,
      wellSize = input$wellplateSize,
    )
  })
  output$wellpicker <- shiny.react::renderReact({
    WellPicker(
      inputId = "wellpicker",
      rows = input$wellpickerRows,
      columns = input$wellpickerColumns,
      displayAsGrid = input$wellpickerGrid,
      wellSize = input$wellpickerSize,
      renderText = JS("({index}) => index")
    )
  })
  output$wellpickerSelected <- renderPrint({
    print(input$wellpicker)
  })

  colors <- reactiveVal()
  output$colorfullwellpicker <- shiny.react::renderReact({
    nrows <- input$colorfullwellpickerRows
    ncols <- input$colorfullwellpickerColumns
    n <- nrows * ncols
    idx <- seq_len(n) - 1L
    row <- idx %/% ncols
    col <- idx %% ncols
    initColors <- pallette[((row %/% 2L) * ((ncols + 2L) %/% 3L) + (col %/% 3L)) %% length(pallette) + 1L]
    colors(initColors)
    ColorfullWellPicker(
      inputId = "colorfullwellpicker",
      rows = input$colorfullwellpickerRows,
      columns = input$colorfullwellpickerColumns,
      displayAsGrid = input$colorfullwellpickerGrid,
      wellSize = input$colorfullwellpickerSize,
      renderText = JS("() => null"),
      colors = initColors
    )
  })

  updateColor <- function(new_color) {
    tmp <- colors()
    tmp[input$colorfullwellpicker+1L] <- new_color
    colors(tmp)
    shiny.react::updateReactInput(
      session, "colorfullwellpicker",
      value = integer(0L),
      colors = colors()
    )
  }

  observeEvent(input$colorfullwellpickerA, {
    updateColor(pallette[1])
  })
  observeEvent(input$colorfullwellpickerB, {
    updateColor(pallette[2])
  })
  observeEvent(input$colorfullwellpickerC, {
    updateColor(pallette[3])
  })
  observeEvent(input$colorfullwellpickerD, {
    updateColor(pallette[4])
  })
  observeEvent(input$colorfullwellpickerE, {
    updateColor(pallette[5])
  })
  observeEvent(input$colorfullwellpickerClear, {
    updateColor("#ffffff")
  })
}

shinyApp(ui = ui, server = server)
