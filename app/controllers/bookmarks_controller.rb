class BookmarksController < ApplicationController
	before_action :set_item, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
  	@bookmark = Bookmark.new
  	authorize @bookmark
  end

  def create
  	@bookmark = Bookmark.new(bookmark_params)
  	authorize @bookmark
  	if @bookmark.save
  		flash[:notice] = "Bookmark was saved."
  		redirect_to @bookmark
  	else
  		flash[:error] = "There was a problem saving your bookmark. Please try again."
  		render :new
  	end
  end

  def edit
  end

  def update
  	authorize @bookmark
  	if @bookmark.update_attributes(bookmark_params)
  		flash[:notice] = "Bookmark was updated."
  		redirect_to @bookmark
  	else
  		flash[:error] = "There was a problem updating your problem. Please try again."
  		redirect_to :edit
  	end
  end

  def destroy
  	if @bookmark.destroy
  		flash[:notice] = "Bookmark was utterly destroyed!"
  		redirect_to @bookmark
  	else
  		flash[:error] = "There was a problem destroying your bookmark. Please try again."
  		render :edit
  	end
  end

  private

  def bookmark_params
  	params.require(:bookmark).permite(:url)
  end

  def set_bookmark
  	@bookmark = Bookmark.find(params[:id])
  end
end
