class Ranking < ActiveRecord::Base
  belongs_to :user
  belongs_to :matter
  attr_accessible :score, :user_id, :matter_id, :week_date

  # scope :weekly, lambda { find_by_sql("SELECT *, SUM(rankings.score) AS 'total_score' FROM rankings, users
  #                             WHERE users.id = rankings.user_id
  #                             AND rankings.created_at >= '#{Time.now.at_beginning_of_week}'
  #                             AND rankings.created_at <= '#{(Time.now + 1.day)}'
  #                             GROUP BY rankings.user_id
  #                             ORDER BY SUM(rankings.score) DESC") }
  # TODO: make the queries by 'scopes'

  before_save :set_the_week_date

  def set_the_week_date
    self.week_date = Time.now.at_beginning_of_week
  end


  class << self

    def all_matter_weekly(date)
      find_by_sql("SELECT * FROM rankings, users
                   WHERE users.id = rankings.user_id
                   AND rankings.week_date = '#{date}'
                   GROUP BY rankings.user_id
                   ORDER BY rankings.score DESC")
    end

    def specific_matter_weekly(date, matter)
      find_by_sql("SELECT * FROM rankings, users
                   WHERE users.id = rankings.user_id
                   AND rankings.week_date = '#{date}'
                   AND rankings.matter = '#{matter}'
                   GROUP BY rankings.user_id
                   ORDER BY rankings.score DESC")
    end

    def summary(user)

      user = find_by_sql("SELECT * FROM rankings, users
                          WHERE users.id = rankings.user_id
                          AND users.id = '#{user.id}'
                          GROUP BY rankings.user_id")


      pre = find_by_sql("SELECT * FROM rankings, users
                         WHERE users.id = rankings.user_id
                         AND users.id <> '#{user.first.id}'
                         GROUP BY rankings.user_id
                         HAVING rankings.score >= #{user.first.score}
                         ORDER BY rankings.score
                         LIMIT 10")

       post = find_by_sql("SELECT * FROM rankings, users
                          WHERE users.id = rankings.user_id
                          GROUP BY rankings.user_id
                          HAVING rankings.score < #{user.first.score}
                          ORDER BY rankings.score DESC
                          LIMIT 10")

        pre.concat(user).concat(post)

    end
  end
end
