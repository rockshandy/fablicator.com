// file for the gallery page to seetup galleria and picasa goodness
var picasa = new Galleria.Picasa().setOptions({description: true});
picasa.useralbum('112269260036389988928','Printed', function(data) {
    $('#galleria').galleria({
        dataSource: data,
        width: 700,
        height: 467
    });
});

