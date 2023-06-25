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
    expect(peeps[0].time_posted).to eq("2023-06-24 14:14:22.188949")

    expect(peeps[0].user_id).to eq(1)

    expect(peeps[1].id).to eq(2)
    expect(peeps[1].content).to eq("content2")
    allow(peeps[2]).to receive(:time_posted).and_return("2023-06-24 14:14:22.188949")
    expect(peeps[1].user_id).to eq(2)
  end
  it 'should return all peeps in the test database' do
    repo = PeepRepository.new
    peep = repo.find(1)
    expect(peep.id).to eq(1)
    expect(peep.content).to eq("content1")
    allow(peep).to receive(:time_posted).and_return("2023-06-24 14:14:22.188949")
    expect(peep.user_id).to eq("1")
  end
  xit 'Should create a new peep' do
    repo = PeepRepository.new
    peep = Peep.new
    peep.content = "test content"
    peep.time_posted = Time.now
    peep.user_id = "2"
    repo.create(peep)
    
    expect(peep.content).to eq("test content")
    
    # Truncate the expected and actual timestamps
    expected_time_truncated = Time.now.round(0)
    actual_time_truncated = peep.time_posted.round(0)
    
    expect(expected_time_truncated).to eq(actual_time_truncated)
    expect(peep.user_id).to eq("2")
  end
  
end