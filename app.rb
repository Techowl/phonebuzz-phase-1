require 'rubygems'
require 'twilio-ruby'
require 'sinatra'

get '/hello-monkey' do
  Twilio::TwiML::Response.new do |r|
    r.Say 'Hello Monkey'
  end.text
end