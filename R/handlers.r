doc_handler <- function(endpoint, path, query, ...) {
  regexp <- paste0("^/custom/", esp_regex(endpoint), "/+(.*)$")
  url <- sub(regexp, "\\1", path)
  params <- process_query(query)
  full_url <- paste0(url, params)

  list(payload = highlight_doc(full_url), "content-type" = "text/html")
}


assets_handler <- function(endpoint, path, ...) {
  regexp <- paste0("^/custom/", esp_regex(endpoint), "/+(.*)$")
  filename <- sub(regexp, "\\1", path)
  assets <- system.file("www", "assets", package = packageName())
  files <- list.files(assets, pattern = filename, full.names = TRUE)
  if (length(files) <= 0) {
    error_page(sprintf("asset %s not found", filename))
  } else {
    f <- files[1]
    list(file = f, "content-type" = mime::guess_type(f))
  }
}


theme_handler <- function(...) {
  list(
    file = get_all_themes()[get_current_theme()],
    "content-type" = "text/css"
  )
}


info_handler <- function(...) {
  payload <- list(
    platform = unbox(platform()),
    dark = unbox(is_dark_theme())
  )

  list(payload = toJSON(payload), "content-type" = "text/json")
}
