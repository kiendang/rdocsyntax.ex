console.log('Hello World from your main file!');
const frame = document.getElementById("rdocsyntax_frame")

frame.addEventListener("load", function () {
  const h2 = this.contentDocument.getElementsByTagName("h2")
  console.log(h2)

  for (const el of h2) {
    el.textContent = el.textContent.toUpperCase()
  }
})
