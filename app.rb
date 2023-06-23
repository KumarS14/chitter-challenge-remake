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
    return erb(:signup_page)
  end
  post '/post-signup' do
    def invalid_credentials?
      return true if params[:email].nil? || params[:password].nil? || params[:user_name] == nil?
    end

    if invalid_credentials?
      status 503
      return 'Signup unsuccessful'
    end
  end
  


end