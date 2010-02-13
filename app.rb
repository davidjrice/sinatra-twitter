require 'rubygems'
require 'sinatra'
require 'twitter'

#oauth.authorize_from_access('access token', 'access secret')

# client = Twitter::Base.new(oauth)
# client.friends_timeline.each  { |tweet| puts tweet.inspect }
# client.user_timeline.each     { |tweet| puts tweet.inspect }
# client.replies.each           { |tweet| puts tweet.inspect }
# 
# client.update('Heeeyyyyoooo from Twitter Gem!')



get '/' do
  File.read(File.join('public', 'index.html'))
end
  
get '/connect' do
  oauth = Twitter::OAuth.new('cV3cvjwaUW6GKoz55nkc8A', '0q3N1wUJKjXeM5R84YhaymsEAFpPVbUoBEOwS3ThuAo')
  session['token'] = oauth.request_token.token
  session['secret'] = oauth.request_token.token
  
  redirect oauth.request_token.authorize_url
end

get '/authorize' do
  oauth = Twitter::OAuth.new('cV3cvjwaUW6GKoz55nkc8A', '0q3N1wUJKjXeM5R84YhaymsEAFpPVbUoBEOwS3ThuAo')
  oauth.authorize_from_request(session['token'], session['secret'], params[:oauth_verifier])

  client = Twitter::Base.new(oauth)
  client.update('Heeeyyyyoooo from Twitter Gem!')
end