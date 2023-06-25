# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/peep_repository'
require_relative 'lib/user_repository'
require 'bcrypt'
enable :sessions


DatabaseConnection.connect('chitter_test_database')

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/peep_repository'
    also_reload 'lib/user_repository'
  end

  get '/signup' do
    erb :signup_page
  end

  post '/post-signup' do
    def invalid_parameters?
      return true if params[:email].nil? || params[:password].nil? || params[:user_name] == nil?
      return true if params[:email] == "" || params[:password] == "" || params[:user_name] == ""
    end

    def invalid_password?
        return true if params[:password].length < 8
    end

    if invalid_parameters?
      status 404
      return 'Signup unsuccessful'
    end

    if invalid_password?
        status 404
        return 'Invalid password please enter one 8 characters long'
    end

    email = params[:email]
    user_name = params[:user_name]
    password = params[:password]
    password_hash =  BCrypt::Password.create(password)
    repo = UserRepository.new
    user = User.new
    user.email = email
    user.password = password_hash
    user.user_name = user_name
    repo.create(user)
   # return 'Signup successful'
    redirect '/login-page'
  end
  get '/login-page' do
    return erb(:login_page)
  end
  post '/login' do
    email = params[:email]
    password = params[:password]
   begin
    repo = UserRepository.new
      user = repo.find_by_email(email)
      if BCrypt::Password.new(user.password) == password
         session[:user_id] = user.id
        puts "Session User ID: #{session[:user_id]}" # Add this line for debugging
        redirect '/make-peep'
      end
    rescue => e
      status = 500
      return 'invalid login credentials please try again' 
    end
  
  end
  get '/make-peep' do
    return erb(:make_peep)

  end
  post '/post-peep' do
    content = params[:content]
    repo = PeepRepository.new
    peep = Peep.new
    peep.content = content
    peep.time_posted = Time.now
    puts "Session User ID in post-peep route: #{session[:user_id]}" # Add this line for debugging
    peep.user_id = session[:user_id]
    repo.create(peep)
  
    puts "Peep ID after creation: #{peep.id}" # Add this line for debugging
    puts "Peep User ID after creation: #{peep.user_id}" # Add this line for debugging
    return session[:user_id]
  end
  
  
  
  
  get '/peeps' do
    repo1 = PeepRepository.new
    repo2 = UserRepository.new
    
    @peeps = repo1.all
    @names = Array.new
    @peeps.length.times do |i|
       users = repo2.find(@peeps[i].user_id)
        @names << users.user_name

    end
    erb :peeps
  end 
end
