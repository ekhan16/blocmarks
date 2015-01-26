class IncomingController < ApplicationController

  # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # You put the message-splitting and business
    # magic here. 

    topic_name = params[:subject]
    url = params["body-plain"]

    user = User.find_or_create_by(email: params['sender'])
    unless user.persisted?
      user.password = (0...8).map { (65 + rand(26)).chr }.join
      user.save
    end

    if topic_name 
      topic = user.topics.find_or_create_by(name: topic_name)
      if topic.save
        bookmark = topic.bookmarks.find_or_create_by(url: url) unless url.blank?
      end
    end

    # Assuming all went well. 
    head 200
  end
end