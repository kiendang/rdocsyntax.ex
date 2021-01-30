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


try_or_else <- function(exp, default) {
  tryCatch(exp, error = function(e) default) %||% default
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


is_nothing <- function(x) {
  length(x) <= 0 || is.null(x) || is.na(x)
}


compare_null <- function(x, y) {
  if (is_nothing(x)) is_nothing(y) else x == y
}


clean_s <- function(s) trimws(tolower(s))


query_to_s <- function(query) {
  params <- sapply(1:length(query), function(i) paste0(names(query[i]), "=", query[i]))
  paste0("?", paste(params, collapse = "&"))
}


filter_view_pane_query <- function(query) {
  vp_i <- which(names(query) == "viewer_pane")
  if (length(vp_i > 0)) {
    head(query, vp_i - 1)
  } else query
}


process_query <- function(query) {
  query_to_s(filter_view_pane_query(query))
}


assets_path <- function() {
  system.file("www", "assets", package = packageName())
}


template_file <- function() {
  file.path(assets_path(), "template.html")
}
