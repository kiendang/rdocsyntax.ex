# Create a temp file preloaded with content and return the file path.
tempf <- function(content, ...) {
  tmp <- tempfile(...)
  cat(content, file = tmp)
  tmp
}


# Read a file into a string character.
# Similar to \code{readr::read_file}.
read_text <- function(f) {
  readChar(f, file.info(f)$size)
}


rs <- function(...) {
  # this instead of rstudioapi:::toolsEnv to make CRAN check happy
  env <- get("toolsEnv", asNamespace("rstudioapi"), inherits = FALSE)
  get(paste(".rs", ..., sep = "."), envir = env())
}


try_or_else <- function(exp, x) {
  tryCatch(exp, error = function(e) x)
}


esp_regex <- function(x) {
  gsub("([.*+?^${}()|])", "\\\\\\1", x)
}


platform <- function() {
  sysname <- tolower(trimws(Sys.info()["sysname"]))

  if (grepl("^dar", sysname)) {
    "macintosh"
  } else if (grepl("^win", sysname)) {
    "windows"
  } else "linux"
}
