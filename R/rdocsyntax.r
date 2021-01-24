#' Create a temp file preloaded with content and return the file path
tempf <- function(content, ...) {
  tmp <- tempfile(...)
  cat(content, file = tmp)
  tmp
}


highlight_doc <- function(url) {
  base_html_file <- system.file("index.html", package = "rdocsyntax")
  base_html <- readChar(base_html_file, file.info(base_html_file)$size)

  localhost_url <- sub("127.0.0.1", "localhost", url)
  html <- sub("%s", localhost_url, base_html)

  tempf(html, fileext = ".html")
}


highlight_viewer <- function(url) {
  rstudioapi::viewer(highlight_doc(url))
}


highlight_browser <- function() {
  browser <- if (rstudioapi::isAvailable() & rstudioapi::hasFun("viewer")) {
    highlight_viewer
  } else getOption("browser")
}


#' @export
use_highlight_browser <- function() {
  options(browser = highlight_browser())
}
