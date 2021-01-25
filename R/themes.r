theme_dirs <- function() {
  default <- system.file("www", "themes", package = packageName())
  global <- try_or_else(rs("getThemeInstallDir")(TRUE), "")
  local <- try_or_else(rs("getThemeInstallDir")(FALSE), "")

  c(default, global, local)
}
