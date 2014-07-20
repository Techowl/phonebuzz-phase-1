require 'rubygems'
require 'twilio-ruby'
require 'sinatra'

get '/hello' do
  Twilio::TwiML::Response.new do |r|
    r.Gather :numDigits => '2', :action => '/hello/fizzbuzz', :method => 'get' do |g|
      g.Say :voice => 'woman', 'Hello! To receive your FizzBuzz results, please enter a number between 1 and 99.'
    end
  end.text
end

get '/hello/fizzbuzz' do
  redirect '/hello' unless params['Digits'] == '1'
  Twilio::TwiML::Response.new do |r|
    r.Say :voice => 'woman', 'Congratulations, you\'ve reached the FizzBuzz stage!'
  end.text
end