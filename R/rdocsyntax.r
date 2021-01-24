tempf <- function(content, ...) {
  tmp <- tempfile(...)
  cat(content, file = tmp)
  tmp
}

#' @export
highlight_browser <- function(url) {
  base_html_file <- system.file("index.html", package = "rdocsyntax")
  base_html <- readChar(base_html_file, file.info(base_html_file)$size)
  url <- sub("127.0.0.1", "localhost", url)
  url <- tempf(
    sub("%s", url, base_html),
    fileext = ".html"
  )

  rstudioapi::viewer(url)
}
