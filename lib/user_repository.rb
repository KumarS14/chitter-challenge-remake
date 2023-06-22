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
   
end