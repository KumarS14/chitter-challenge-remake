require 'pg'
require 'user_repository.rb'
def reset_users_table
  connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_test_database' })

 
end

describe UserRepository do
  before(:each) do
    reset_users_table
  end

  it 'should return all users in the test database' do
    repo = UserRepository.new
    users = repo.all
    expect(users.length).to eq(4)
    expect(users[0].id).to eq(1)
    expect(users[0].email).to eq("email1@gmail.com")
    expect(users[0].user_name).to eq("user1")
    expect(users[0].password).to eq("password1")

    expect(users[1].id).to eq(2)
    expect(users[1].email).to eq("email2@gmail.com")
    expect(users[1].user_name).to eq("user2")
    expect(users[1].password).to eq("password2")
  end
  it 'Should find one specific user' do
    repo = UserRepository.new
    user = repo.find(1)
    expect(user.id).to eq(1)
    expect(user.email).to eq("email1@gmail.com")
    expect(user.user_name).to eq("user1")
    expect(user.password).to eq("password1")

  end
end
