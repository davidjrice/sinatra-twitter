require 'rubygems'
require 'sinatra'
require 'twitter'

enable :sessions

get '/' do
  File.read(File.join('public', 'index.html'))
end

get '/connect' do
  oauth = Twitter::OAuth.new('cV3cvjwaUW6GKoz55nkc8A', '0q3N1wUJKjXeM5R84YhaymsEAFpPVbUoBEOwS3ThuAo')
  session['token'] = oauth.request_token.token
  session['secret'] = oauth.request_token.secret

  oauth.set_callback_url('http://208.75.85.139:4567/authorize')
  redirect oauth.request_token.authorize_url
end

get '/authorize' do
  oauth = Twitter::OAuth.new('cV3cvjwaUW6GKoz55nkc8A', '0q3N1wUJKjXeM5R84YhaymsEAFpPVbUoBEOwS3ThuAo')
  oauth.authorize_from_request(session['token'], session['secret'], params['oauth_verifier'])

  client = Twitter::Base.new(oauth)
  client.update('Heeeyyyyoooo from Twitter Gem!')
end