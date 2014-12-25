jQuery(document).ready(function(){
  if($('.demots-pag .pagination').length){
    $('.pagination').hide();
    $(window).scroll(function(){
      var url = $('.pagination a[rel="next"]').attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 50){
        $('.pagination').empty();
        $('#loader').append("<p class='text-center'>Loading more cool images...<p>");

        $.getScript(url);
      }
    });
  };
});
