#!/usr/bin/env ruby
# encoding: utf-8

require 'tweetstream'
require 'yaml'

begin
    path = File.expand_path(File.dirname(__FILE__))
    SETTINGS = YAML::load(open(path + "/conf/token.conf"))
rescue
    puts "Config file load failed."
    exit
end

#TweetStream.configure do |config|
#    config.consumer_key = SETTINGS["CONSUMER_KEY"]
#    config.consumer_secret = SETTINGS["CONSUMER_SECRET"]
#    config.oauth_token = SETTINGS["OAUTH_TOKEN"]
#    config.oauth_token_secret = SETTINGS["OAUTH_TOKEN_SECRET"]
#    config.auth_method = :oauth
#end

tc = Twitter::REST::Client.new do |config|
    config.consumer_key = SETTINGS["CONSUMER_KEY"]
    config.consumer_secret = SETTINGS["CONSUMER_SECRET"]
    config.access_token = SETTINGS["OAUTH_TOKEN"]
    #config.oauth_token = SETTINGS["OAUTH_TOKEN"]
    config.access_token_secret = SETTINGS["OAUTH_TOKEN_SECRET"]
    #config.oauth_token_secret = SETTINGS["OAUTH_TOKEN_SECRET"]
end

#p tc.user.id
profile = tc.get('/1.1/users/show.json', {:user_id => tc.user.id}).body
puts profile[:profile_image_url]
#p profile[:profile_image_url_https]
#puts tc.get('/1.1/users/show.json', {:user_id => tc.user.id}).body
