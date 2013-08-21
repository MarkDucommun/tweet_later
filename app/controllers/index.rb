get '/' do
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  # if session[:user_id]
  #   user = User.find(session[:user_id])
  #     @access_token = user.oauth_token
  # # else
    @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
    puts @access_token.inspect
    puts @access_token.methods
    session.delete(:request_token)
    # our request token is only valid until we use it to get an access token, so let's delete it from our session
    # if @access_token
      puts @access_token
      @user = User.find_or_create_by_username(username: @access_token.params[:screen_name], oauth_token: @access_token.token, oauth_secret: @access_token.secret)
      puts @user
     
      session[:user_id] = @user.id
    # end
 
  # at this point in the code is where you'll need to create your user account and store the access token


  erb :index
  
end


post '/' do
  puts "------------------------------------"
  puts twitter_client.update(params[:tweet])
  redirect '/'
end
