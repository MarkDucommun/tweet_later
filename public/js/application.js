$(document).ready(function() {
  $('#processing').hide();

  $('form').on('submit', function(e){
    e.preventDefault();

    $('#processing').show();
    
    $('.success').hide();
    
    var data = $(this).serialize();
    
    $('textarea').prop('disabled', true);
    
    $.post('/', data, function(response) {
      
        setTimeout(function(){
          $.get('/status/' + response, function(response){
           
          if (response == "stuff"){
            $('#processing').hide();
            $('.messages').append('<p class="success">You have successfully tweeted</p>');}
    
          else {
            $('.messages').append('<p class="success">Error</p>');}

          $('textarea').prop('disabled', false);

          })
        }, 1000)
    });
  });
});
