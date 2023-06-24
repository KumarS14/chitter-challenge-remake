require_relative 'user.rb'
require 'bcrypt'
class UserRepository

    # Selecting all records
    # No arguments
    def all
      # Executes the SQL query:
      sql = 'SELECT id, email, user_name, password FROM users;'
      result_set = DatabaseConnection.exec_params(sql,[])
      users = []
      result_set.each do |row|
        user = User.new
        user.id = row['id'].to_i
        user.email = row['email']
        user.user_name = row['user_name']
        user.password = row['password']
        users << user
      end
       return users
    end
   def find(id)
    sql = 'SELECT * FROM users WHERE id = $1;'
    params = DatabaseConnection.exec_params(sql,[id])
    result_set = params[0]
    user = User.new
    user.id = result_set['id'].to_i
    user.email = result_set['email']
    user.user_name = result_set['user_name']
    user.password = result_set['password']
    return user

   end
   def create(user)
    sql = 'INSERT INTO users (email, user_name, password) VALUES ($1, $2, $3);'
    params = [user.email, user.user_name, user.password]
    result_set = DatabaseConnection.exec_params(sql,params)
    return user
   end
   def find_by_email(email)
    sql = "SELECT id, email, user_name, password FROM users WHERE email = $1;"
    result_set = DatabaseConnection.exec_params(sql,[email])
    result = result_set[0]
    user = User.new
    user.id = result['id'].to_i
    user.email = result['email']
    user.user_name = result['user_name']
    user.password = result['password']
    return user
  end
  def update_password(user_id, password)
    hashed_password = BCrypt::Password.create(password)
    sql = 'UPDATE users SET password = $1 WHERE id = $2;'
    params = [hashed_password, user_id]
    DatabaseConnection.exec_params(sql, params)
  end

  def update_all_passwords
    users = all
    users.each do |user|
      update_password(user.id, user.password)
    end
  end




end