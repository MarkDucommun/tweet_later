class TweetWorker 
  include Sidekiq::Worker

  def perform(tweet_id)
    puts "PERFORMING TWEET"
    tweet = Tweet.find(tweet_id)
    client = tweet.user.get_client
    client.update(tweet.text)
  end
end
