import "ace-builds/src-min-noconflict/ace"
import "ace-builds/src-min-noconflict/mode-r"
import "ace-builds/src-min-noconflict/ext-static_highlight"


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

const rsthemeLink = () => {
  const link = document.createElement("link")
  link.setAttribute("type", "text/css")
  link.setAttribute("rel", "stylesheet")
  link.setAttribute("id", "rstudio-acethemes-linkelement")
  link.setAttribute("href", "/custom/rdocsyntax-rstheme")

  return link
}

const setRCSS = e => {
  const links = e.querySelectorAll("head link")

  Array(...links)
    .filter(node => node.getAttribute("href") === "R.css")
    .forEach(node => {
      node.setAttribute("href", "/custom/rdocsyntax-assets/R.css")
    })
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

frame.addEventListener("load", e => {
  const d = e.currentTarget.contentDocument

  highlightCode(d)
  removeIndentGuides(d)
  setRCSS(d)
  addRsthemeLink(d)
})
