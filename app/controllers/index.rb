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
  access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  session.delete(:request_token)
  user = User.find_or_create_by_username(
    username: access_token.params[:screen_name],
    oauth_token: access_token.token,
    oauth_secret: access_token.secret) 
  session[:user_id] = user.id
  redirect '/'
end

get '/status/:job_id' do
  if job_is_complete(params[:job_id])
    return false
  else
    return true
  end
end



post '/' do
  puts "------------------------------------"
  user = User.find(session[:user_id])
  job_id = user.tweet(params[:tweet])
  return job_id
end

