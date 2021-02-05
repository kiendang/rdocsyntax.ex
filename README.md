# Syntax highlighting for R HTML documentation


*WARNING: You should check out [`kiendang/rdocsyntax`](https://github.com/kiendang/rdocsyntax) instead.
It's faster and integrates better with RStudio.*

Overview
--------

This package enables syntax highlighting for R HTML documentation.

Syntax highlighting follows RStudio theme when running RStudio, otherwise uses Textmate theme.

<img src="screenshots/before.png" alt="before" width=650px/><img src="screenshots/after.png" alt="after" width=650px/>
<!-- ![before](screenshots/before.png =50x) ![after](screenshots/after.png =50x) -->

*SOME CAVEATS*

  - *You might notice the highlighted doc is displayed inside RStudio Viewer pane instead of Help pane. This is a limitation. Thus things like forward, backward, ... are unavailable. You should check out [`kiendang/rdocsyntax`](https://github.com/kiendang/rdocsyntax) instead for those features. It also has the advantage of being faster.*


Getting Started
---------------

Install the package

```r
# install.packages("devtools")
devtools::install_github("kiendang/rdocsyntax.ex")
```


Enable syntax highlighting

```r
rdocsyntax.ex::highlight_html_docs()
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

Disable syntax highlighting

```r
rdocsyntax.ex::unhighlight_html_docs()
```


Extras
------

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
