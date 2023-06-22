require 'pg'
require 'peep_repository.rb'
def reset_peeps_table
  connection = PG.connect({ host: '127.0.0.1', dbname: 'chitter_test_database' })

 
end

describe PeepRepository do
  before(:each) do
    reset_peeps_table
  end

  it 'should return all peeps in the test database' do
    repo = PeepRepository.new
    peeps = repo.all
    expect(peeps.length).to eq(4)
    expect(peeps[0].id).to eq(1)
    expect(peeps[0].content).to eq("content1")
    expect(peeps[0].time_posted).to eq("2023-06-22 13:01:05.449966")
    expect(peeps[0].user_id).to eq("1")

    expect(peeps[1].id).to eq(2)
    expect(peeps[1].content).to eq("content2")
    expect(peeps[1].time_posted).to eq("2023-06-22 13:01:05.452201")
    expect(peeps[1].user_id).to eq("2")
  end
end