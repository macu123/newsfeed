class FeedsController < ApplicationController
  def index
    @feeds = Feed.page(1)
  end

  def next_page
    Feed.page(params[:page]).next_page
  end
end
