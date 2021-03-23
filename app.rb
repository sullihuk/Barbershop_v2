require 'rubygems'
require 'sinatra'
require 'sinatra/contrib/all'
require 'sqlite3'



def is_barber_exists? db, name
	db.execute('select * from BARBERS where name = ?', [name]).length > 0
end

def seed_db db, barbers
	barbers.each do |barber| 
		if !is_barber_exists? db, barber
			db.execute 'insert into barbers (name) values (?)', [barber]
		end
	end
end

def get_db
	db = SQLite3::Database.new './public/bsh.db'
	db.results_as_hash = true
	db
end


def check 

	get_db

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
				get_db.execute "INSERT INTO CUSTOMERS (NAME, PHONE, DATESTAMP, BARBER, COLOR) VALUES (?,?,?,?,?)", [@username, @phone, @date, @barber,  @color]
			end

	get_db.close

end

before do
    @barbers = get_db.execute 'select * from barbers'
end

configure do
		get_db.execute "CREATE TABLE IF NOT EXISTS
		'BARBERS'
		(
			'ID' INTEGER PRIMARY KEY AUTOINCREMENT,
			'NAME' TEXT
			)"
		seed_db get_db, ["Walter White", "Gustavo Fring", "Michael Ehrmantrauth", "Skylar"]
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
    	get_db
    	#db = SQLite3::Database.new './public/bsh.db'
		#db.results_as_hash = true

		@list = get_db.execute 'select * from customers order by id desc;' 
			
		   	
    	erb :list
    else
    	@error_1 = "Не вошедше"
    	erb :admin
    end
	
end