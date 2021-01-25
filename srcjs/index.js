import "ace-builds/src-min-noconflict/ace"
import "ace-builds/src-min-noconflict/mode-r"
import "ace-builds/src-min-noconflict/ext-static_highlight"


const highlight = ace.require("ace/ext/static_highlight")

const frame = document.getElementById("rdocsyntax_frame")

const getBody = e =>
  e.currentTarget.contentDocument.querySelector("body")

const highlightCode = e => {
  const codeBlocks = e.currentTarget.contentDocument.querySelectorAll("pre")

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
  link.setAttribute("href", "/custom/rstheme")

  return link
}

const setRCSS = e => {
  const links = e.currentTarget.contentDocument.querySelectorAll("head link")

  Array(...links)
    .filter(node => node.getAttribute("href") === "R.css")
    .forEach(node => {
      node.setAttribute("href", "/custom/assets/R.css")
    })
}

const addRsthemeLink = e => {
  const body = e.currentTarget.contentDocument.querySelector("body")
  body.appendChild(rsthemeLink())
}

frame.addEventListener("load", e => {
  highlightCode(e)
  setRCSS(e)
  addRsthemeLink(e)
})
