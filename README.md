# Syntax highlighting for R docs in RStudio

Overview
--------

This package enables syntax highlighting for R code inside R documentation when using RStudio.

Syntax highlighting follows the same theme you set for RStudio.

<img src="screenshots/before.png" alt="before" width=650px/><img src="screenshots/after.png" alt="after" width=650px/>
<!-- ![before](screenshots/before.png =50x) ![after](screenshots/after.png =50x) -->

*SOME CAVEATS*

  - *The package is still in very early stage so expect some roughness around the edges.*
  - *It has only been tested on MacOS.*
  - *You might notice the highlighted doc is displayed inside RStudio Viewer pane instead of Help pane. This is a limitation. Thus things like forward, backward, search, ... unavailable (for now, maybe).*
  - *If you switch between light and dark themes, you have to restart RStudio. Switching from light to light, dark to dark theme works without restarting (probably).*
  - *The implementation of this package is a bit of a hack. Though it works (for me at least), ultimately this is something that (I think) is better to be implemented inside RStudio itself.*


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


Enjoy R docs with colorful code

```r
?sapply
```
