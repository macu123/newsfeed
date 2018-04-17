# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'net/http'

def parse_json_from(url)
  uri = URI(url)
  response = Net::HTTP.get(uri)
  JSON.parse(response)
end

Feed.destroy_all
Comment.destroy_all

HACKERNEWS_URL = 'https://hacker-news.firebaseio.com/v0/'

url = HACKERNEWS_URL + 'topstories.json'
item_ids = parse_json_from(url)

item_ids.each do |item_id|
  url = HACKERNEWS_URL + 'item/' + "#{item_id}.json"  
  news_feed = parse_json_from(url)
  feed = Feed.create!(
      created_by: news_feed['by'],
      comments_count: news_feed['descendants'],
      score: news_feed['score'],
      title: news_feed['title'],
      url: news_feed['url'],
      created_at: Time.at(news_feed['time'])
    )

  puts "Feed with ID #{feed.id} is created!"

  next unless news_feed['kids']

  news_feed['kids'].each do |comment_id|
    url = HACKERNEWS_URL + 'item/' + "#{comment_id}.json"
    news_comment = parse_json_from(url)
    comment = feed.comments.create!(
        created_by: news_comment['by'],
        text: news_comment['text'],
        created_at: Time.at(news_comment['time'])
      )

    puts "Comment with ID #{comment.id} is created!"
  end
end