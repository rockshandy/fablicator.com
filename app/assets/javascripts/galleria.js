//= require galleria-1.2.5
//= require galleria.classic
//= require galleria.picasa

$(function(){
  $('#tabs a').click(function(){
    picasa_galleria($(this).data('album'))
  });
});

function picasa_galleria(gallery){
  $('.galleria-container').remove();
  $('.selected').removeClass('selected')
  $('a[data-album="'+ gallery +'"]').closest('li').addClass('selected')
  var picasa = new Galleria.Picasa().setOptions({description: true});
  picasa.useralbum('112269260036389988928',gallery, function(data) {
      $('#galleria').galleria({
          dataSource: data,
          width: 700,
          height: 467
      });
  });
}