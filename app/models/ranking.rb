class Ranking < ActiveRecord::Base
  belongs_to :user
  attr_accessible :score, :user_id
  
  # scope :weekly, lambda { find_by_sql("SELECT *, SUM(rankings.score) AS 'total_score' FROM rankings, users
  #                             WHERE users.id = rankings.user_id
  #                             AND rankings.created_at >= '#{Time.now.at_beginning_of_week}'
  #                             AND rankings.created_at <= '#{(Time.now + 1.day)}'
  #                             GROUP BY rankings.user_id
  #                             ORDER BY SUM(rankings.score) DESC") }
  # TODO: make the queries by 'scopes'
  
  class << self
    
    def weekly
      find_by_end_date Time.now.at_beginning_of_week
    end
    
    def monthly
      find_by_end_date Time.now.at_beginning_of_month
    end
    
    def find_by_end_date(date)
      find_by_sql("SELECT *, SUM(rankings.score) AS 'total_score' FROM rankings, users
                   WHERE users.id = rankings.user_id
                   AND rankings.created_at >= '#{date}'
                   AND rankings.created_at <= '#{(Time.now.tomorrow)}'
                   GROUP BY rankings.user_id
                   ORDER BY total_score DESC")
    end
    
    def summary(user)
      
      user = find_by_sql("SELECT *, SUM(rankings.score) AS 'total_score' FROM rankings, users
                          WHERE users.id = rankings.user_id
                          AND users.id = '#{user.id}'
                          GROUP BY rankings.user_id")

      
      pre = find_by_sql("SELECT *, SUM(rankings.score) AS 'total_score' FROM rankings, users
                         WHERE users.id = rankings.user_id
                         AND users.id <> '#{user.first.id}'
                         GROUP BY rankings.user_id
                         HAVING total_score >= #{user.first.total_score}
                         ORDER BY total_score
                         LIMIT 10")
      
       post = find_by_sql("SELECT *, SUM(rankings.score) AS 'total_score' FROM rankings, users
                          WHERE users.id = rankings.user_id
                          GROUP BY rankings.user_id
                          HAVING total_score < #{user.first.total_score}
                          ORDER BY total_score DESC
                          LIMIT 10")
                          
        pre.concat(user).concat(post)
      
    end
  end
end
