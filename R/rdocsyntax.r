highlight_doc <- function(url) {
  base_html_file <- system.file("index.html", package = "rdocsyntax")
  base_html <- read_text(base_html_file)

  localhost_url <- sub("127.0.0.1", "localhost", url)
  html <- sub("%s", localhost_url, base_html)

  tempf(html, fileext = ".html")
}


highlight_viewer <- function(url) {
  rstudioapi::viewer(highlight_doc(url))
}


highlight_browser <- function() {
  if (rstudioapi::isAvailable() & rstudioapi::hasFun("viewer")) {
    highlight_viewer
  } else getOption("browser")
}


#' @export
use_highlight_browser <- function() {
  options(browser = highlight_browser())
}
