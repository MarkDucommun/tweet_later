$(document).ready(function() {
  $('#processing').hide();

  $('form').on('submit', function(e){
    e.preventDefault();

    $('#processing').show();
    
    $('.success').hide();
    
    var data = $(this).serialize();
    
    $('textarea').prop('disabled', true);
    
    $.post('/', data, function(response) {
      
      keepGoing = true
      
      while(keepGoing){
        setInterval(function(){

          $.get('/status/' + response, function(response){
             console.log(response)
             keepGoing = response
          })

        }, 100)
      }
      if (response){
        $('#processing').hide();
        $('.messages').append('<p class="success">You have successfully tweeted</p>');}
    
      else {
        $('.messages').append('<p class="success">Error</p>');}

      $('textarea').prop('disabled', false);
    });
  });
});
