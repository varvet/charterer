var $form = $('.edit_image');

var toggleSpinner = function(state) {
  $('.images').height( $('#main').width() + 30 );
  if(state) {
    $('#loading').addClass('active');
    $('#image').removeClass('active');
  }
  else {
    $('#loading').removeClass('active');
    $('#image').addClass('active');
  }
};

var loadImage = function(url) {
  toggleSpinner(true);
  var newImg = $('<img src="'+url+'" class="img" alt="" />');
  newImg.on('load', function() { toggleSpinner(false); });
  $('.img').replaceWith(newImg);
};

$form.on('ajax:success', function(e, data) {
  $form.attr('action', '/images/' + data.id);
  $('#image_tag_list').val('');
  loadImage(data.url);
});

$('#main').on('click', '.tag', function(e) {
  e.preventDefault();
  var $tag = $(e.currentTarget);
  $('#image_tag_list').val( $tag.data('name') );
  $form.submit();
});

loadImage($('.img').data('url'));