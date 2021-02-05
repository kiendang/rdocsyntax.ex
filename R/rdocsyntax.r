#' @importFrom stats setNames
#' @importFrom utils browseURL packageName head assignInMyNamespace
#' @importFrom tools startDynamicHelp
#' @importFrom jsonlite toJSON unbox
#' @importFrom httr parse_url
#' @importFrom rlang %||%
#' @importFrom whisker whisker.render


highlight_doc <- function(url) {
  # template <- read_text(template_file())

  # use localhost so that this can be opened in the Viewer pane using rstudio::viewer
  localhost_url <- sub(esp_regex("127.0.0.1"), "localhost", url)
  whisker.render(template, list(
    url = localhost_url,
    background = get_background(),
    foreground = get_foreground()
  ))
}


highlight_url <- function(url) {
  httpd_url(sprintf("/custom/%s/%s", prepend_endpoint("frame"), trimws(url)))
}


highlight_browser <- function(default) {
  default_f <- browser_f(default)

  local_browser <- if (rstudioapi::isAvailable() & rstudioapi::hasFun("viewer")) {
    rstudioapi::viewer
  } else default_f

  function(url) {
    if (same_origin(parse_url(url), parse_url(httpd_origin()))) {
      local_browser(highlight_url(url))
    } else default_f(url)
  }
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
#' @details
#' R html docs are displayed by running the doc url through a browser function.
#' The browser in use is stored in the \code{browser} option, \code{getOption("browser")}.
#' This package works by creating a browser function that takes in the R doc html,
#' applies syntax highlighting, then displays it using the previously set browser, or,
#' in case RStudio is running, \code{\link[rstudioapi]{viewer}}.
#'
#' @seealso \code{\link[utils]{browseURL}}
#'
#' @examples
#'
#' \dontrun{
#' # minimal example, using RStudio
#' # original R html doc without syntax highlighting
#' ?sapply
#'
#' # enable syntax highlighting
#' highlight_html_docs()
#'
#' # Code in HTML documents is now highlighted
#' ?sapply
#' # or if help pages are not displayed in HTML mode by default,
#' # e.g. when R is not running inside RStudio
#' help(sapply, help_type = "html")
#'
#' #' # Disable syntax highlighting
#' unhighlight_html_docs()
#' }
#'
#' @export
highlight_html_docs <- function() {
  setup_handlers()
  start_httpd()

  original_browser <- get_original_browser()
  options(browser = highlight_browser(original_browser))
}


#' Disable HTML documentation syntax highlighting
#'
#' @description
#' Revert to the original help server for handling HTML documentation.
#'
#' @seealso \code{\link{highlight_html_docs}}
#'
#' @export
unhighlight_html_docs <- function() {
  options(browser = get_original_browser())
  assignInMyNamespace("original_browser", NULL)
}
