class TweetsController < ApplicationController
    def new
        @tweet = Tweet.new
    end

    def create
        @tweet = Tweet.new(tweet_params)
        @tweet.shortened = RubyLLM.chat.ask("You are an expert on Tweeter (X). Generate a Tweet from this text #{@tweet.long}. maximum 160 characters. Use hashtags.").content
        if @tweet.save
            redirect_to tweet_path(@tweet)
        else
            render :new, status: :unpricessable_entity
        end
    end

    def show
        @tweet = Tweet.find(params[:id])
    end


    private

    def tweet_params
        params.require(:tweet).permit(:long)
    end
end
