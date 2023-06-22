
## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE users, peeps CASCADE;

INSERT INTO users (email, user_name, password) VALUES ('email1@gmail.com', 'user1','password1');
INSERT INTO users (email, user_name, password) VALUES ('email2@gmail.com', 'user2', 'password2');
INSERT INTO users (email, user_name, password) VALUES ('email3@gmail.com', 'user3', 'password3');
INSERT INTO users (email, user_name, password) VALUES ('email4@gmail.com', 'user4', 'password4');

INSERT INTO peeps (content, time_posted, user_id) VALUES ('content1', CURRENT_TIMESTAMP, 1);
INSERT INTO peeps (content, time_posted, user_id) VALUES ('content2', CURRENT_TIMESTAMP, 2);
INSERT INTO peeps (content, time_posted, user_id) VALUES ('content3', CURRENT_TIMESTAMP, 3);
INSERT INTO peeps (content, time_posted, user_id) VALUES ('content4', CURRENT_TIMESTAMP, 3);

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: users

# Model class
# (in lib/user.rb)
class User
end

class Peep

# Repository class
# (in lib/user_repository.rb)
class UserRepository
end

class PeepRepository
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: users

# Model class
# (in lib/user.rb)

class User

  # Replace the attributes by your own columns.
  attr_accessor :id, :email, :username, :password
end
class Peep
  attr_accessor :id, :content, :time_posted, :user_id
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# user = user.new
# user.name = 'Jo'
# user.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: users

# Repository class
# (in lib/user_repository.rb)

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
      user.username = row['username']
      user.password = row['password']
      users << user
    end
     return user
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM users WHERE id = $1;

    # Returns a single user object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(user)
  # end

  # def update(user)
  # end

  # def delete(user)
  # end
end
```

```

Encode this example as a test.

## 6. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/user_repository_spec.rb

def reset_users_table
  seed_sql = File.read('spec/seeds_users.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'users' })
  connection.exec(seed_sql)
end

describe userRepository do
  before(:each) do 
    reset_users_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy%2Fdatabases&prefill_File=resources%2Frepository_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->