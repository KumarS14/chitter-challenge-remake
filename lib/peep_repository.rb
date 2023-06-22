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
    def find(id)
        sql = 'SELECT id, content, time_posted, user_id from peeps where id = $1;'
        result_set = DatabaseConnection.exec_params(sql,[id])
        result = result_set[0]
            peep = Peep.new
            peep.id = result['id'].to_i
            peep.content = result['content']
            peep.time_posted = result['time_posted']
            peep.user_id = result['user_id']
        return peep

    end
    def create(peep)
        sql = 'INSERT INTO peeps (content, time_posted, user_id) VALUES ($1, $2, $3);'
        params = [peep.content, peep.time_posted, peep.user_id]
        sql_params = DatabaseConnection.exec_params(sql,params)
        return peep
    end

end