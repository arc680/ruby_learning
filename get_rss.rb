# -*- coding: utf-8 -*-
require 'rss'

rss = RSS::Parser.parse('http://b.hatena.ne.jp/hotentry?mode=rss')

rss.items.each do |item|
    puts item.title
    puts item.link
    puts "---"
end
