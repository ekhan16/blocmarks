class TopicsController < ApplicationController
  def index
  	@topics = Topic.all
  end

  def show
  	@topic = Topic.find(params[:id])
  	@bookmarks = @topic.bookmarks
  end

  def new
  	@topic = Topic.new
  end

  def edit
  end
end
