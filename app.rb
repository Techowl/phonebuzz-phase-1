require 'rubygems'
require 'twilio-ruby'
require 'sinatra'
require 'dotenv'

Dotenv.load
@auth_token = ENV['AUTH_TOKEN']

get '/hello' do
  validator = Twilio::Util::RequestValidator.new(@auth_token)
  uri = request.url
  params = env['rack.request.query_hash']
  signature = env['HTTP_X_TWILIO_SIGNATURE']
  return unless validator.validate uri, params, signature
  Twilio::TwiML::Response.new do |r|
    r.Gather :finishOnKey => '#', :action => '/hello/fizzbuzz', :method => 'get' do |g|
      g.Say 'Hello! To receive your FizzBuzz results, please enter a number between 1 and 999 followed by the pound sign.'
    end
  end.text
end

get '/hello/fizzbuzz' do
  validator = Twilio::Util::RequestValidator.new(@auth_token)
  uri = request.original_url
  params = env['rack.request.query_hash']
  signature = env['HTTP_X_TWILIO_SIGNATURE']
  return unless validator.validate uri, params, signature
  number = params['Digits'].to_i
  redirect '/hello' unless (number >= 1 && number <= 999)
  Twilio::TwiML::Response.new do |r|
    number.times do |i|
      curr_num = i + 1
      if curr_num % 15 == 0
        r.Say "fizz buzz"
      elsif curr_num % 5 == 0
        r.Say "buzz"
      elsif curr_num % 3 == 0
        r.Say "fizz"
      else
        r.Say "#{curr_num}"
      end
    end
  end.text
end