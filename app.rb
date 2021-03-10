require 'rubygems'
require 'sinatra'
require 'sinatra/contrib'

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href =\"http://rubyschool.us/\">Ruby school</a>!!!"
end

get '/about' do
	erb :about 
end

get '/visit' do
	erb :visit
end

get '/contacts' do
	erb :contacts
end

post '/visit' do
	username = params[:username]
	phone = params[:phone]
	date = params[:date]
	barber = params[:barber]
	@soobshalovo = "Dear #{username}, yours phone is #{phone}, you arive at #{date} yours barber is #{barber}."
	 
	fial = File.open './public/users.txt', 'a'
	fial.write "Dear #{username}, yours phone is #{phone}, you arive at #{date}, yours barber is #{barber}</br>"
	fial.write "\n"
	
	erb :visit
end

get '/admin' do
	erb "tunn"
	erb :admin
end

get '/list' do
	erb :list
 end

post '/admin' do
	login = params[:login]
	password = params[:password]
     
    if login == 'admin' && password == '2233'
    	@list = File.read './public/users.txt'
    	
    else
    	@error_1 = "Не вошедше"
    	erb :admin
    end
	erb :list
end