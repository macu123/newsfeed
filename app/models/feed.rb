class Feed < ActiveRecord::Base
  has_many :comments

  paginates_per 30

  def displayed_website
    return nil unless self.url
    
    arr = self.url.split('//')
    if arr.size > 1
      website = arr[1]
    else
      website = arr[0]
    end
    website = website.split('/')[0]
    website.sub!('www.', '') if website.starts_with?('www')
    website
  end

  def displayed_time
    num_hours = ((Time.now - self.created_at) / 3600).round
    "#{num_hours} hours ago"
  end
end
