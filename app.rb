# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/peep_repository'
require_relative 'lib/user_repository'

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
    repo = UserRepository.new
    user = User.new
    user.email = email
    user.password = password
    user.user_name = user_name
    repo.create(user)
    return 'Signup successful'
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
