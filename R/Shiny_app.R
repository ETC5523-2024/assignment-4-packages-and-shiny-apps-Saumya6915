#' Launch the Shiny App from the inst Folder
#'
#' This function launches a Shiny application located in the inst folder of the package.
#' @param launch.browser Logical; if TRUE, opens the app in the default web browser.
#'
#' @return No return value; the function is called for its side effect of launching the app.
#' @examples
#' launch_shiny_app()
#' @export
launch_shiny_app <- function(launch.browser = TRUE) {
  app_directory <- system.file("shiny-app.R", package = "MelbournePrices")

  # Check if the app file exists
  if (!file.exists(app_directory)) {
    stop("The Shiny app file does not exist in the inst folder.")
  }
  # Launch the Shiny app
  shiny::runApp(app_directory, launch.browser = launch.browser)
}
