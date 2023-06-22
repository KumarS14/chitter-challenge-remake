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
  end
end
