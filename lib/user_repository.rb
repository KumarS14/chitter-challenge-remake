require 'user.rb'
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
        user.username = row['user_name']
        user.password = row['password']
        users << user
      end
       return users
    end
end