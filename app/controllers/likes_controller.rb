class LikesController < ApplicationController
	before_action :find_bookmark, only: [:create, :destroy]

	def create
		like = current_user.likes.build(bookmark: @bookmark)
		authorize @like

		if like.save
			flash[:notice] = "You liked this bookmark. Hooray."
			redirect_to @bookmark
		else
			flash[:error] = "There was an issue liking this bookmark. Mayhap you should try again."
			redirect_to @bookmark
		end
	end

	def destroy
		@like = Like.current_user.find(params[:id])
		authorize @like

		if like.destroy
			flash[:notice] = "Your like was annihilated!"
			redirect_to @bookmark
		else
			flash[:error] = "There was a problem destroying your like. Please attempt once more."
			redirect_to @bookmark
		end
	end

	private

	def find_bookmark
		@bookmark = Bookmark.find(params[:bookmark_id])
	end
end
