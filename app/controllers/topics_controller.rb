class TopicsController < ApplicationController
  def index
  	@topics = Topic.all
    authorize @topics
  end

  def show
  	@topic = Topic.find(params[:id])
  end

  def new
  	@topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      flash[:notice] = "Topic was saved."
      redirect_to @topic
    else
      flash[:error] = "Topic was not saved due to an error. Try again."
      render :new
    end
  end

  def edit
    @topic = Topic.find(params[:id])
    authorize @topic
  end

  def update
    @topic = Topic.find(params[:id])
    authorize @topic
    if @topic.update_attributes(topic_params)
      flash[:notice] = "Topic was updated."
      redirect_to @topic
    else
      flash[:error] = "Topic was not updated due to an error. Try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:id])
    if @topic.destroy
      flash[:notice] = "Topic has been destroyed!"
      redirect_to @topic
    else
      flash[:error] = "Problem destroying topic.  Please try again."
      render :edit
    end
  end

  private
    def topic_params
      params.require(:topic).permit(:title)
    end
end
