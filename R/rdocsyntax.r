#' Create a temp file preloaded with content and return the file path
tempf <- function(content, ...) {
  tmp <- tempfile(...)
  cat(content, file = tmp)
  tmp
}

#' @export
highlight_browser <- function(url) {
  base_html_file <- system.file("index.html", package = "rdocsyntax")
  base_html <- readChar(base_html_file, file.info(base_html_file)$size)

  localhost_url <- sub("127.0.0.1", "localhost", url)
  html <- sub("%s", localhost_url, base_html)
  html_file <- tempf(html, fileext = ".html")

  rstudioapi::viewer(html_file)
}
