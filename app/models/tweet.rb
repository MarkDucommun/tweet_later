class Tweet < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user

  # after_create :tweet_it

  # def tweet_it
  #   puts "this is when tweeting happens"
  #   TweetWorker.perform_async(self)
  # end
end
