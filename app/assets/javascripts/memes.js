$(window).load(function(){
  function updateCanvas(){
  var canvas = document.getElementById('canvas');
  var context = canvas.getContext("2d");
  var imageObj = new Image();

  function drawCanvas(){
    context.drawImage(imageObj, 0, 0);
  }
  function updateText(){
    context.font = "40pt Calibri";
      var upperText = $('textarea#upperText').val().toUpperCase();
      var bottomText = $('textarea#bottomText').val().toUpperCase();
      context.fillText(upperText, 20, 80);
      context.fillText(bottomText, 20, 540);
      var url = canvas.toDataURL('image/jpeg');
      $("#meme_image").val(url)    
  }

  imageObj.src = $("#canvas_image").attr('src');
  imageObj.onload = function(){
    drawCanvas();
    updateText();
  }
  };
  updateCanvas();
  $('textarea#upperText, textarea#bottomText').change(function(){updateCanvas()});
  $('textarea#upperText, textarea#bottomText').keyup(function(){updateCanvas()});
});
