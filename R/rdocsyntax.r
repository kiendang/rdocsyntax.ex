highlight_doc <- function(url) {
  base_html_file <- system.file("index.html", package = "rdocsyntax")
  base_html <- read_text(base_html_file)

  # use localhost so that this can be opened in the Viewer pane using rstudio::viewer
  localhost_url <- sub("127.0.0.1", "localhost", url)
  html <- sub("%s", localhost_url, base_html)

  tempf(html, fileext = ".html")
}


highlight_viewer <- function(url) {
  rstudioapi::viewer(httpd_url(sprintf("/custom/frame/%s", trimws(url))))
}


doc_handler <- function(path, ...) {
  url_regexp <- "^/custom/frame/+(.*)$"
  url <- sub(url_regexp, "\\1", path)
  list(file = highlight_doc(url))
}


setup_handlers <- function() {
  env <- get(".httpd.handlers.env", asNamespace("tools"))
  env[["frame"]] <- doc_handler
}


#' @export
use_highlight_browser <- function() {
  if (rstudioapi::isAvailable() & rstudioapi::hasFun("viewer")) {
    setup_handlers()
    options(browser = highlight_viewer)
  }
}
