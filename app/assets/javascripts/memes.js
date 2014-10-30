$(window).load(function(){
  console.log("inside load function")
  function updateCanvas(){
  var canvas = document.getElementById('canvas');
  var context = canvas.getContext("2d");
  var imageObj = new Image();

  function drawCanvas(){
    console.log(imageObj)
    context.drawImage(imageObj, 0, 0);
  }
  function updateText(){
    console.log("inside updatetext")
    context.font = "40pt Calibri";
      var upperText = $('textarea#upperText').val().toUpperCase();
      var bottomText = $('textarea#bottomText').val().toUpperCase();
      context.fillText(upperText, 20, 80);
      context.fillText(bottomText, 20, 540);
  }

  imageObj.src = $("#canvas_image").attr('src');
  imageObj.onload = function(){
    console.log("inside onload")
    drawCanvas();
    updateText();
  }
  };
  updateCanvas();
  $('textarea#upperText, textarea#bottomText').change(function(){updateCanvas()});
  $('textarea#upperText, textarea#bottomText').keyup(function(){updateCanvas()});
});
