doc_handler <- function(endpoint, path, ...) {
  regexp <- paste0("^/custom/", endpoint, "/+(.*)$")
  url <- sub(regexp, "\\1", path)
  list(file = highlight_doc(url))
}


assets_handler <- function(endpoint, path, ...) {
  regexp <- paste0("^/custom/", endpoint, "/+(.*)$")
  filename <- sub(regexp, "\\1", path)
  assets <- system.file("www", "assets", package = packageName())
  file <- list.files(assets, pattern = filename, full.names = TRUE)[1]
  list(file = file, "content-type" = mime::guess_type(file))
}
