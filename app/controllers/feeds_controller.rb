class FeedsController < ApplicationController
  def index
    @feeds = Feed.page(1)
  end

  def next_page
    response = if params[:page]
      next_page = params[:page].to_i + 1
      Feed.page(next_page)
    else
      {}
    end
    
    render json: response, status: :ok
  end
end
