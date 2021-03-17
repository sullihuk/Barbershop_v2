require 'rubygems'
require 'sinatra'
require 'sinatra/contrib'
require 'sqlite3'



def check 

	@db = SQLite3::Database.new './public/bsh.db'

			hh = {:username => "Введите имя",
				:phone => 'Введите телефон',
				:date => 'Заполните поле "Когда вас ждать"'
				#:colour => 'Выберите цвет'
				}

			@error3 = hh.select {|key,_| params[key] == ""}.values.join(", ")

			if @error3 != ''
			
				return erb :visit
			else
				@notice = "Dear #{@username} we will pend you at #{@date}, #{@phone}, #{@barber} #{@color}"
				@db.execute "INSERT INTO CUSTOMERS (NAME, PHONE, BARBER, DATESTAMP, COLOR) VALUES (?,?,?,?,?)", [@username, @phone, @date, @barber, @color]
			end

	@db.close

end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href =\"http://rubyschool.us/\">Ruby school</a>"
end

get '/about' do
	@error = 'something wrong!'
	erb :about 
end

get '/visit' do
	erb :visit
end

get '/contacts' do
	erb :contacts
end

post '/contacts' do
	@email = params[:email]
	@message = params[:message]
end

post '/visit' do
	@username = params[:username]
	@phone = params[:phone]
	@date = params[:date]
	@barber = params[:barber]
	@color = params[:color]
	

	check

	erb :visit
		
end

get '/admin' do
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