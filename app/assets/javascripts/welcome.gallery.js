// file for the gallery page to seetup galleria and picasa goodness
$(function(){
  $('#tabs a').click(function(){
    $('.selected').removeClass('selected')
    $(this).closest('li').addClass('selected')
    picasa_galleria($(this).text())
  });
});

function picasa_galleria(gallery){
  $('.galleria-container').remove();
  var picasa = new Galleria.Picasa().setOptions({description: true});
  picasa.useralbum('112269260036389988928',gallery, function(data) {
      $('#galleria').galleria({
          dataSource: data,
          width: 700,
          height: 467
      });
  });
}

