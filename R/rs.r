# https://github.com/rstudio/rstudio/blob/ddcd7191ec89c4da00e77afae7e9f27e61e87c36/src/cpp/session/modules/SessionThemes.R#L724
rs_getThemeName <- function(themeLines, fileName) {
  tmThemeNameRegex <- "<key>name</key>\\s*<string>([^>]*)</string>"
  rsthemeNameRegex <- "rs-theme-name\\s*:\\s*([^\\*]+?)\\s*(?:\\*|$)"
  nameRegex <- tmThemeNameRegex
  nameLine <- themeLines[grep(tmThemeNameRegex, themeLines,
                              perl = TRUE, ignore.case = TRUE)]
  if (length(nameLine) == 0) {
    nameRegex <- rsthemeNameRegex
    nameLine <- themeLines[grep(rsthemeNameRegex, themeLines,
                                perl = TRUE, ignore.case = TRUE)]
  }
  if (length(nameLine) == 0) {
    regmatches(basename(fileName), regexec("^([^\\.]*)(?:\\.[^\\.]*)?",
                                           basename(fileName), perl = TRUE))[[1]][2]
  }
  else {
    sub("^\\s*(.+?)\\s*$", "\\1", regmatches(nameLine, regexec(nameRegex,
                                                               nameLine, perl = TRUE))[[1]][2], perl = TRUE)
  }
}
