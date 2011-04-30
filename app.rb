require 'sinatra'
require 'erb'
require_relative 'pony_gmail'

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
              :password   => 'derkaderka',
              :authentication       => :plain,
              :domain     => "yourdomain.com"
             }
           )
  "Email sent!"
end