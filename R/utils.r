#' Create a temp file preloaded with content and return the file path.
tempf <- function(content, ...) {
  tmp <- tempfile(...)
  cat(content, file = tmp)
  tmp
}


#' Read a file into a string character.
#' Similar to \code{readr::read_file}.
read_text <- function(f) {
  readChar(f, file.info(f)$size)
}


httpd_url <- function(path) {
  paste0("http://localhost:", tools::startDynamicHelp(NA), path)
}


rs <- function(...) {
  get(paste(".rs", ..., sep = "."), envir = rstudioapi:::toolsEnv())
}


try_or_else <- function(exp, x) {
  tryCatch(exp, error = function(e) x)
}


theme_dirs <- function() {
  default <- system.file("www", "themes", package = packageName())
  global <- try_or_else(rs("getThemeInstallDir")(TRUE), "")
  local <- try_or_else(rs("getThemeInstallDir")(FALSE), "")

  c(default, global, local)
}


httpd_handlers_env <- function() {
  get(".httpd.handlers.env", asNamespace("tools"))
}


add_handler <- function(endpoint, handler, env = httpd_handlers_env()) {
  env[[endpoint]] <- function(...) handler(endpoint, ...)
}
