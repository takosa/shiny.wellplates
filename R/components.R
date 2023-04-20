reactWellPlatesDependency <- function() {
  htmltools::htmlDependency(
    name = "shiny.wellplates",
    version = "0.1.0",
    package = "shiny.wellplates",
    src = "www",
    script = "shiny-wellplates.js"
  )
}

component <- function(name) {
  function(...) shiny.react::reactElement(
    module = "react-well-plates",
    name = name,
    props = shiny.react::asProps(...),
    deps = reactWellPlatesDependency()
  )
}

input <- function(name, defaultValue) {
  function(inputId, ..., value = defaultValue) {
    shiny.react::reactElement(
      module = "@/shiny.wellplates",
      name = name,
      props = shiny.react::asProps(inputId = inputId, ..., value = value),
      deps = reactWellPlatesDependency()
    )
  }
}


#' @export
WellPlate <- component("WellPlate")

#' @export
WellPicker.shinyInput <- input("MultiWellPicker", integer(0L))

#' @export
ColorfullWellPicker <- input("ColorfullWellPicker", integer(0L))
