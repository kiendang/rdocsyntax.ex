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


rs <- function(...) {
  get(paste(".rs", ..., sep = "."), envir = rstudioapi:::toolsEnv())
}


try_or_else <- function(exp, x) {
  tryCatch(exp, error = function(e) x)
}


esp_regex <- function(x) {
  gsub("([.*+?^${}()|])", "\\\\\\1", x)
}
