require 'sinatra'
require 'erb'

begin 
 # try to use require_relative first
 # this only works for 1.9
 require_relative 'pony_gmail.rb'
rescue NameError
 # oops, must be using 1.8
 # no problem, this will load it then
 require File.expand_path('pony_gmail.rb', __FILE__)
end

get '/' do
  erb :index
end

post '/appointment' do
  Pony.mail(:to=>"bicyclescissors@gmail.com", 
            :from => 'bicyclescissors@gmail.com', 
            :subject=> params["email_addr"],
            :body => params["message"],
            :via => :smtp, :via_options => {
              :address       => 'smtp.gmail.com',
              :port       => '587',
              :user_name       => 'bicyclescissors@gmail.com',
              :password   => 'blarg',
              :authentication       => :plain,
              :domain     => "yourdomain.com"
             }
           )
  "Email sent!"
end