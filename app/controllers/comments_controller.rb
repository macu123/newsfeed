class CommentsController < ApplicationController
  before_action :set_feed

  def index
    @comments = @feed.comments.order('created_at DESC')
  end

  private
  def set_feed
    @feed = Feed.find(params[:feed_id])
  end
end
