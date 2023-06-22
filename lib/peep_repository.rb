require 'peep.rb'
class PeepRepository
    def all
        sql = 'SELECT id, content, time_posted, user_id FROM peeps;'
        result_set = DatabaseConnection.exec_params(sql,[])
        peeps = []
        result_set.each do |row|
            peep = Peep.new
            peep.id = row['id'].to_i
            peep.content = row['content']
            peep.time_posted = row['time_posted']
            peep.user_id = row['user_id']
            peeps << peep
        end
        return peeps
    end


end