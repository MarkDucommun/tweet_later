class User < ActiveRecord::Base

  has_many :tweets
  
  def get_client
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.access_token = self.oauth_token
      config.access_token_secret = self.oauth_secret
    end
    client
  end

  def tweet(status)
    tweet = self.tweets.create(text: status)
    TweetWorker.perform_async(tweet.id)
  end
end
