class Feed < ActiveRecord::Base
  has_many :comments

  paginates_per 30
end
