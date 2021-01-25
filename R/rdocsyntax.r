#' @importFrom stats setNames
#' @importFrom utils packageName
#' @importFrom whisker whisker.render


highlight_doc <- function(url) {
  base_html_file <- system.file("index.html", package = packageName())
  base_html <- read_text(base_html_file)

  # use localhost so that this can be opened in the Viewer pane using rstudio::viewer
  localhost_url <- sub(esp_regex("127.0.0.1"), "localhost", url)
  whisker.render(base_html, list(url = localhost_url))
}


highlight_viewer <- function(url) {
  rstudioapi::viewer(
    httpd_url(sprintf("/custom/%s/%s", prepend_endpoint("frame"), trimws(url)))
  )
}


setup_handlers <- function() {
  env <- httpd_handlers_env()
  add_handler("frame", doc_handler, env)
  add_handler("assets", assets_handler, env)
  add_handler("rstheme", theme_handler, env)
}


#' Enable syntax highlighting in R doc viewed with RStudio
#'
#' @export
use_highlight_browser <- function() {
  if (rstudioapi::isAvailable() & rstudioapi::hasFun("viewer")) {
    setup_handlers()
    options(browser = highlight_viewer)
  }
}
