require 'rubygems'
require 'sinatra'
require 'twitter'

callback_url = 'http://208.75.85.139:4567/authorize'
consumer_key = 'cV3cvjwaUW6GKoz55nkc8A'
consumer_secret = '0q3N1wUJKjXeM5R84YhaymsEAFpPVbUoBEOwS3ThuAo'

enable :sessions

get '/' do
  File.read(File.join('public', 'index.html'))
end

get '/connect' do
  oauth = Twitter::OAuth.new(consumer_key, consumer_secret)
  session['token'] = oauth.request_token.token
  session['secret'] = oauth.request_token.secret

  oauth.set_callback_url(callback_url)
  redirect oauth.request_token.authorize_url
end

get '/authorize' do
  oauth = Twitter::OAuth.new(consumer_key, consumer_secret)
  oauth.authorize_from_request(session['token'], session['secret'], params['oauth_verifier'])

  client = Twitter::Base.new(oauth)
  client.update('Heeeyyyyoooo from Twitter Gem!')
end