class TweetsController < ApplicationController
    before_action :require_user_logged_in
    before_action :set_tweet, only: [:edit, :update, :show, :destroy]

    def index
        @tweets = Current.user.tweets
    end

    def new
        @tweet = Tweet.new  
    end

    def edit
    end

    def create
        @tweet = Current.user.tweets.create(tweet_params)
        Rails.logger.error(@tweet.errors.full_messages.join(', '))
        if @tweet.save
         redirect_to tweets_path , notice: 'Tweet was successfully scheduled'
        else
          render :new, status: :unprocessable_entity
        end
    end

    def update
        if @tweet.update(tweet_params)
         redirect_to tweets_path , notice: 'Tweet was Updated successfully'
        else
          render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @tweet.destroy
        redirect_to tweets_path, notice: 'Tweet was UnScheduled'
    end
  
    private
      def tweet_params
          params.require(:tweet).permit(:twitter_account_id, :body, :publish_at)
      end

      def set_tweet
        @tweet = Current.user.tweets.find(params[:id])
      end

end