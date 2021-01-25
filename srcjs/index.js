import "ace-builds/src-min-noconflict/ace"
import "ace-builds/src-min-noconflict/mode-r"
import "ace-builds/src-min-noconflict/ext-static_highlight"


const highlight = ace.require("ace/ext/static_highlight")

const frame = document.getElementById("rdocsyntax_frame")

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

  return link
}

const addRsthemeLink = e => {
  const body = e.currentTarget.contentDocument.querySelector("body")
  body.appendChild(rsthemeLink())
}

frame.addEventListener("load", e => {
  highlightCode(e)
  addRsthemeLink(e)
})
