# Syntax highlighting for R HTML documentation

Overview
--------

This package enables syntax highlighting for R HTML documentation.

Syntax highlighting follows RStudio theme when running RStudio, otherwise uses Textmate theme. Theme customization outside of Rstudio might be supported in the future, maybe (*The themes are there, I'm just lazy to actually write the code atm...*).

<img src="screenshots/before.png" alt="before" width=650px/><img src="screenshots/after.png" alt="after" width=650px/>
<!-- ![before](screenshots/before.png =50x) ![after](screenshots/after.png =50x) -->

*SOME CAVEATS*

  - *The package is still in very early stage so expect some roughness around the edges.*
  - *It has only been thoroughly tested on MacOS, though support for Windows, Linux is included.*
  - *You might notice the highlighted doc is displayed inside RStudio Viewer pane instead of Help pane. This is a limitation. Thus things like forward, backward, ... are unavailable (at least for now).*


Getting Started
---------------

Install the package

```r
# install.packages("devtools")
devtools::install_github("kiendang/rdocsyntax")
```


Enable syntax highlighting

```r
rdocsyntax::use_highlight_browser()
```


If using outside RStudio, set `help_type` to `html` to automatically display doc in HTML mode. Otherwise `?` syntax won't work, use `help(..., help_type = "html")` instead.

```r
options(help_type = "html")
```


Enjoy R docs with colorful code

```r
?sapply
# or help(sapply, help_type = "html")
```


Extras
------

### Revert to original state

To enable switching off syntax highlighting, *i.e.* be able to revert to original state

```r
original_browser <- rdocsyntax::use_highlight_browser()
# ...
# revert to original state
getOptions(browser = original_browser)
```

### Single line `## Not run`

There are `## Not run` code examples that are single line. *e.g* in `?rstudioapi::highlightUi`

```r
## Not run: rstudioapi::highlightUi("#rstudio_workbench_panel_git")
```

The code will not be syntax-highlighted because the whole line is considered a comment.

The solution we use is to turn it into

```r
## Not run:
rstudioapi::highlightUi("#rstudio_workbench_panel_git")
```

in the generated html.
