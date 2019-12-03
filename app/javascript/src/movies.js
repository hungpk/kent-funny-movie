document.addEventListener("turbolinks:load", () => {
  $('[data-toggle="tooltip"]').tooltip()
  setTimeout(() => {
    $(".alert").hide()
  }, 5000)

})
