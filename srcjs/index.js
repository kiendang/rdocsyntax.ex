import "ace-builds/src-min-noconflict/ace"
import "ace-builds/src-min-noconflict/mode-r"
import "ace-builds/src-min-noconflict/ext-static_highlight"

import rstudioDarkStyles from "./rstudio-dark.txt.css"


const highlight = ace.require("ace/ext/static_highlight")

const frame = document.getElementById("rdocsyntax_frame")


const singleLineNotRunRegex = /(?<=^[^\S\n\r]*##[^\S\n\r]+Not run:)[^\S\n\r]+/gm

const addLineBreakNotRun = s => s.replace(singleLineNotRunRegex, "\n")

const getCodeBlocks = e => [...e.querySelectorAll("pre")]

const handleSingleLineNotRun = codeBlocks => {
  codeBlocks.forEach(code => {
    code.textContent = addLineBreakNotRun(code.textContent)
  })
}

const highlightCode = codeBlocks => {
  codeBlocks.forEach(code => {
    highlight(code, {
      mode: "ace/mode/r",
      showGutter: false,
      trim: true
    }, _highlighted => { })
  })
}


const setRCSS = e => {
  const links = [...e.querySelectorAll("head link")]

  links
    .filter(node => node.getAttribute("href").endsWith("R.css"))
    .forEach(node => {
      node.setAttribute("href", "/custom/rdocsyntax-assets/R.css")
    })
}


const setMainTitle = e => {
  const title = e.querySelector("head title")
  const mainTitle = document.querySelector("title#rdocsyntax-main-title")

  mainTitle.textContent = title.textContent
}


const bodyClasses = ["rstudio-themes-flat", "ace_editor_theme"]

const setBodyClasses = e => {
  const body = e.querySelector("body")

  bodyClasses.forEach(cls => body.classList.add(cls))
}


const getInfo = () => (
  fetch(new Request("/custom/rdocsyntax-info"))
    .then(response => response.json())
)


const platforms = ["macintosh", "windows", "linux"]

const defaultPlatfrom = "linux"

const getOS = response => {
  const platform = response.platform
  if (!platform) {
    return defaultPlatfrom
  }

  const trimmed = platform.trim()
  return platforms.includes(trimmed) ? trimmed : defaultPlatfrom
}

const setOS = (e, info) => {
  const body = e.querySelector("body")

  info
    .then(getOS)
    .then(platform => { body.classList.add(platform) })
    .catch(() => { body.classList.add(defaultPlatfrom) })
}


const lightThemeClasses = [
  "rstudio-themes-light-menus",
  "rstudio-themes-default"
]

const darkThemeClasses = [
  "editor_dark",
  "rstudio-themes-dark",
  "rstudio-themes-dark-menus",
  "rstudio-themes-dark-grey"
]

const defaultThemeClasses = [...lightThemeClasses]

const isDark = response => (
  response.dark ?? false
)

const isDarkPromise = info => (
  info.then(isDark)
)

const darkLightThemeClasses = dark => (
  dark ? darkThemeClasses : lightThemeClasses
)

const setDarkLightThemeClasses = (e, dark) => {
  const body = e.querySelector("body")

  dark
    .then(darkLightThemeClasses)
    .then(classes => {
      classes.forEach(cls => { body.classList.add(cls) })
    })
    .catch(() => {
      defaultThemeClasses.forEach(cls => { body.classList.add(cls) })
    })
}


const rsthemeLink = () => {
  const link = document.createElement("link")
  link.setAttribute("type", "text/css")
  link.setAttribute("rel", "stylesheet")
  link.setAttribute("id", "rstudio-acethemes-linkelement")
  link.setAttribute("href", "/custom/rdocsyntax-rstheme")

  return link
}

const addRsthemeLink = e => {
  const body = e.querySelector("body")
  body.appendChild(rsthemeLink())
}


const removeIndentGuides = e => {
  const body = e.querySelector("body")
  const nodes = [...body.querySelectorAll(".ace_indent-guide")]

  nodes.forEach(node => {
    node.classList.remove("ace_indent-guide")
  })
}


const addDarkThemeStyle = (e, dark) => {
  dark.then(dark => {
    if (dark) {
      const head = e.querySelector("head")

      const node = document.createElement("style")
      node.textContent = rstudioDarkStyles

      head.appendChild(node)
    }
  })
}


const handleExternalLinks = e => {
  const anchors = [...e.querySelectorAll("a")]

  anchors.forEach(a => {
    const href = a.getAttribute("href")

    // https://github.com/rstudio/rstudio/blob/5ceee580ed6f632cdcc68f5978545e0b23a5a704/src/gwt/src/org/rstudio/studio/client/workbench/views/help/HelpPane.java#L348
    if (href.includes(":") || href.endsWith(".pdf")) {
      a.setAttribute("target", "_blank")
      a.setAttribute("rel", "noopener noreferrer")
    }
  })
}


const yolo = f => {
  try { f() } catch { }
}


const info = getInfo()

const dark = isDarkPromise(info)


frame.addEventListener("load", e => {
  const d = e.currentTarget.contentDocument

  const codeBlocks = getCodeBlocks(d)

  Array(
    () => { setMainTitle(d) },
    () => { setBodyClasses(d) },
    () => { addDarkThemeStyle(d, dark) },
    () => { setDarkLightThemeClasses(d, dark) },
    () => { setOS(d, info) },
    () => { handleSingleLineNotRun(codeBlocks) },
    () => { highlightCode(codeBlocks) },
    () => { removeIndentGuides(d) },
    () => { setRCSS(d) },
    () => { addRsthemeLink(d) },
    () => handleExternalLinks(d)
  ).forEach(yolo)
})
