theme_dirs <- function() {
  default <- system.file("www", "themes", package = packageName())
  global <- try_or_else(rs("getThemeInstallDir")(TRUE), "")
  local <- try_or_else(rs("getThemeInstallDir")(FALSE), "")

  c(default, global, local)
}


get_all_themes <- function() {
  theme_dirs <- theme_dirs()
  theme_files <- unname(unlist(c(sapply(
    theme_dirs,
    list.files, pattern = "*.rstheme$", recursive = TRUE, full.names = TRUE
  ))))

  themes <- sapply(theme_files, function(f) {
    theme <- try_or_else(rs("getThemeName")(readLines(f), basename(f)))
    c(theme, f)
  }, simplify = FALSE, USE.NAMES = FALSE)

  sapply(themes, function(theme) {
    setNames(theme[2], theme[1])
  })
}
