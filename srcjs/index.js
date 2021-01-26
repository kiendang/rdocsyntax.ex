import "ace-builds/src-min-noconflict/ace"
import "ace-builds/src-min-noconflict/mode-r"
import "ace-builds/src-min-noconflict/ext-static_highlight"

import rstudioDarkStyles from "./rstudio-dark.txt.css"


const highlight = ace.require("ace/ext/static_highlight")

const frame = document.getElementById("rdocsyntax_frame")


const highlightCode = e => {
  const codeBlocks = e.querySelectorAll("pre")

  Array(...codeBlocks).forEach(codeBlock => {
    highlight(codeBlock, {
      mode: "ace/mode/r",
      theme: null,
      showGutter: false,
      trim: true
    }, _highlighted => { })
  })
}


const setRCSS = e => {
  const links = e.querySelectorAll("head link")

  Array(...links)
    .filter(node => node.getAttribute("href") === "R.css")
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
  "rstudio-theme-light-menus",
  "rstudio-themes-default"
]

const darkThemeClasses = [
  "editor_dark",
  "rstudio-theme-dark",
  "rstudio-theme-dark-menus",
  "rstudio-theme-dark-grey"
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
  const nodes = body.querySelectorAll(".ace_indent-guide")
  Array(...nodes).forEach(node => {
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


const yolo = f => {
  try { f() } catch { }
}


frame.addEventListener("load", e => {
  const d = e.currentTarget.contentDocument

  const info = getInfo()
  const dark = isDarkPromise(info)

  Array(
    () => { setMainTitle(d) },
    () => { setBodyClasses(d) },
    () => { addDarkThemeStyle(d, dark) },
    () => { setDarkLightThemeClasses(d, dark) },
    () => { setOS(d, info) },
    () => { highlightCode(d) },
    () => { removeIndentGuides(d) },
    () => { setRCSS(d) },
    () => { addRsthemeLink(d) }
  ).forEach(yolo)
})
