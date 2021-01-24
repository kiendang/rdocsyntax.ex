import 'ace-builds/src-min-noconflict/ace'
import 'ace-builds/src-min-noconflict/mode-r'
import 'ace-builds/src-min-noconflict/ext-static_highlight'


const frame = document.getElementById('rdocsyntax_frame')

const highlight = ace.require('ace/ext/static_highlight')

frame.addEventListener('load', function () {
  const code = this.contentDocument.querySelectorAll('pre')

  Array.apply(null, code).forEach(function (codeEl) {
    highlight(codeEl, {
      mode: 'ace/mode/r',
      theme: null,
      showGutter: false,
      trim: true
    }, function (_highlighted) { })
  })
})
