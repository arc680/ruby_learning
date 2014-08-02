# -*- coding: utf-8 -*-
require 'open-uri'
require 'json'
require 'fileutils'

def getjson(uri)
  json_data = ""
  begin
    open(uri) do |f|
      p f
      json_data = JSON.load(f)
    end
    return json_data
  rescue => exception
    case exception
    when OpenURI::HTTPError
      #puts uri + " is 404"
      return nil
    else
      #puts exception.to_s + "(#{exception.class})"
      return nil
    end
  end
end

def getkaomoji(json_data)
  return json_data['record']['text']  
end


today = Time.now.strftime("%Y%m%d")
p today.to_s
#file = open(today.to_s + "_kaomoji-n-at.txt", "w")

id = 0
cnt = 0
loop do
  id += 1
  uri = "http://kaomoji.n-at.me/" + id.to_s + ".json"
  json_data = getjson(uri)
  next if json_data == nil
  kaomoji = getkaomoji(json_data)
  cnt += 1
  p id.to_s + "("+ cnt.to_s + ")" + "\tかお\t" + kaomoji + "\t顔文字\n"
end
