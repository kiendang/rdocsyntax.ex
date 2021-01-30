httpd_origin <- function() {
  paste0("http://localhost:", startDynamicHelp(NA))
}


httpd_url <- function(...) {
  paste0(httpd_origin(), ...)
}


same_scheme <- function(x, y) {
  x <- clean_s(x)
  y <- clean_s(y)

  if (is_nothing(x)) is_nothing(y)
  else if (x %in% c("http", "https")) y %in% c("http", "https")
  else x == y
}


same_host <- function(x, y) {
  x <- clean_s(x)
  y <- clean_s(y)

  if (is_nothing(x)) is_nothing(y)
  else if (x %in% c("localhost", "127.0.0.1")) y %in% c("localhost", "127.0.0.1")
  else x == y
}


same_port <- function(x, y) {
  x <- clean_s(x)
  y <- clean_s(y)

  compare_null(x, y)
}


same_origin <- function(x, y) {
  same_scheme(x$scheme, y$scheme) &&
    same_host(x$host, y$host) &&
    same_port(x$port, y$port)
}


httpd_handlers_env <- function() {
  get(".httpd.handlers.env", asNamespace("tools"))
}


add_handler <- function(endpoint, handler, env = httpd_handlers_env()) {
  endpoint <- prepend_endpoint(endpoint)
  env[[endpoint]] <- function(...) handler(endpoint, ...)
}


endpoint_prefix <- function() {
  tolower(paste0(packageName(), "-"))
}


prepend_endpoint <- function(endpoint) {
  paste0(endpoint_prefix(), endpoint)
}


start_httpd <- function() {
  try(suppressMessages(startDynamicHelp(TRUE)), silent = TRUE)
}


browser_f <- function(br) {
  if (is.function(br)) br else {
    function(url) browseURL(url, browser = br)
  }
}


error_response <- function(status_code, msg) {
  payload <- list(
    error = unbox(msg)
  )

  list(
    payload = toJSON(payload),
    "content-type" = "text/json",
    headers = NULL,
    "status code" = status_code
  )
}
