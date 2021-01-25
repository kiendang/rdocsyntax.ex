doc_handler <- function(endpoint, path, ...) {
  regexp <- paste0("^/custom/", esp_regex(endpoint), "/+(.*)$")
  url <- sub(regexp, "\\1", path)
  list(highlight_doc(url))
}


assets_handler <- function(endpoint, path, ...) {
  regexp <- paste0("^/custom/", esp_regex(endpoint), "/+(.*)$")
  filename <- sub(regexp, "\\1", path)
  assets <- system.file("www", "assets", package = packageName())
  file <- list.files(assets, pattern = filename, full.names = TRUE)[1]
  list(file = file, "content-type" = mime::guess_type(file))
}


theme_handler <- function(endpoint, path, ...) {
  list(
    file = get_all_themes()[rstudioapi::getThemeInfo()$editor],
    "content-type" = "text/css"
  )
}
