class Comment < ActiveRecord::Base
  belongs_to :feed

  def displayed_time
    num_hours = ((Time.now - self.created_at) / 3600).round
    "#{num_hours} hours ago"
  end
end
