@loadFile = (event) ->
  output = document.getElementById('image-preview')
  output.src = URL.createObjectURL(event.target.files[0])
  return
