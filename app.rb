require 'rubygems'
require 'twilio-ruby'
require 'sinatra'

get '/hello' do
  Twilio::TwiML::Response.new do |r|
    r.Gather :finishOnKey => '#', :action => '/hello/fizzbuzz', :method => 'get' do |g|
      g.Say 'To receive your FizzBuzz results, please enter a number between 1 and 999 followed by the pound sign.'
    end
  end.text
end

get '/hello/fizzbuzz' do
  number = params['Digits']
  redirect '/hello' unless (type(number) == 'int' && number >= 1 && number <= 999)
  Twilio::TwiML::Response.new do |r|
    r.Say "Congratulations, you've reached the FizzBuzz stage with number #{number}!"
  end.text
end