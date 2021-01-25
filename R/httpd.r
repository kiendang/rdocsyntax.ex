httpd_url <- function(path) {
  paste0("http://localhost:", tools::startDynamicHelp(NA), path)
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
  try(suppressMessages(tools::startDynamicHelp(TRUE)), silent = TRUE)
}


error_page <- function(msg) {
  list(payload = paste0(HTMLheader("httpd error"), msg, "\n</body></html>"))
}
