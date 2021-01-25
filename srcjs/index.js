import 'ace-builds/src-min-noconflict/ace'
import 'ace-builds/src-min-noconflict/mode-r'
import 'ace-builds/src-min-noconflict/ext-static_highlight'


const highlight = ace.require('ace/ext/static_highlight')

const frame = document.getElementById('rdocsyntax_frame')

frame.addEventListener('load', e => {
  const codeBlocks = e.currentTarget.contentDocument.querySelectorAll('pre')

  Array(...codeBlocks).forEach(codeBlock => {
    highlight(codeBlock, {
      mode: 'ace/mode/r',
      theme: null,
      showGutter: false,
      trim: true
    }, _highlighted => { })
  })
})
