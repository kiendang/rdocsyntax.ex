#' @importFrom stats setNames
#' @importFrom utils browseURL packageName
#' @importFrom jsonlite toJSON unbox
#' @importFrom rlang %||%
#' @importFrom whisker whisker.render


highlight_doc <- function(url) {
  base_html_file <- system.file("index.html", package = packageName())
  base_html <- read_text(base_html_file)

  # use localhost so that this can be opened in the Viewer pane using rstudio::viewer
  localhost_url <- sub(esp_regex("127.0.0.1"), "localhost", url)
  whisker.render(base_html, list(
    url = localhost_url,
    background = get_background(),
    foreground = get_foreground()
  ))
}


highlight_url <- function(url) {
  httpd_url(sprintf("/custom/%s/%s", prepend_endpoint("frame"), trimws(url)))
}


highlight_browser <- function(default) {
  br <- if (rstudioapi::isAvailable() & rstudioapi::hasFun("viewer")) {
    rstudioapi::viewer
  } else default

  br_f <- if (is.function(br)) br else {
    function(url) browseURL(url, browser = br)
  }

  function(url) br_f(highlight_url(url))
}


setup_handlers <- function() {
  env <- httpd_handlers_env()
  add_handler("frame", doc_handler, env)
  add_handler("assets", assets_handler, env)
  add_handler("rstheme", theme_handler, env)
  add_handler("info", info_handler, env)
}


#' Enable syntax highlighting in R html doc
#'
#' @param set_html_help_type
#' Automatically set the \code{help_type} option to \code{html},
#' i.e. \code{options(help_type = "html")}. Default is \code{FALSE}.
#'
#' @details
#' R html docs are displayed by running the doc url through a browser function.
#' The browser in use is stored in the \code{browser} option, \code{getOption("browser")}.
#' This package works by creating a browser function that takes in the R doc html,
#' applies syntax highlighting, then displays it using the previously set browser, or,
#' in case RStudio is running, \code{rstudio::viewer}.
#'
#' @return
#' The original browser
#'
#' @examples
#'
#' \dontrun{
#' # minimal example, using RStudio
#' # original R html doc without syntax highlighting
#' ?sapply
#' # enable syntax highlighting
#' use_syntax_highlight()
#' ?sapply
#' }
#'
#' \dontrun{
#' # this works if not using RStudio
#' # set html doc, alternatively can use help(..., help_type = "html")
#' options(help_type = "html")
#' # original R html doc without syntax highlighting
#' ?sapply
#' # enable syntax highlighting
#' use_syntax_highlight()
#' ?sapply
#' }
#'
#' \dontrun{
#' # in case you want to be able switch off syntax highlighting,
#' # i.e. revert to original state
#'
#' # store the original browser
#' original_browser <- use_syntax_highlight()
#' # revert to the original browser
#' options(browser = original_browser)
#' }
#'
#' @export
use_highlight_browser <- function(set_html_help_type = FALSE) {
  setup_handlers()
  start_httpd()

  if (set_html_help_type) {
    options(help_type = "html")
  }

  original_browser <- getOption("browser")
  options(browser = highlight_browser(original_browser))
  invisible(original_browser)
}
