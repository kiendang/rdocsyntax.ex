template <- readr::read_file(file.path("inst", "www", "assets", "template.html"))
usethis::use_data(template, internal = TRUE, overwrite = TRUE)
