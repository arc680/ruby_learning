# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'

$key = ""
$value = ""

def check_even(num)
  if num % 2 == 0
    return 1
  else
    return 0
  end
end

def insert_data(num, data)
  if check_even(num) == 0
    $key = data
  else
    $value = data
  end
end

def get_personal_data(url)
  hash_data = Hash::new
  doc = Nokogiri::HTML(open(url))
  jubegraph = doc.xpath("//td[@valign='top']/table[@align='center']")
  personal = jubegraph[0].xpath(".//tr/td")
  i = 1
  
  personal.each do |d|
    div_part = d.xpath(".//div")
    if div_part.size != 0
      div_part.each do |dp|
        data = dp.content
        insert_data(i, data)
        i += 1
      end
    else
      data = d.content
      if data != ""
        insert_data(i, data)
        i += 1
      end
    end
    
    if $key != "" && $value != ""
      hash_data[$key] = $value
      $key = ""
      $value = ""
    end
  end

  return hash_data
end

url = "http://jubegraph.dyndns.org/jubeat_saucer/score.cgi?rid=57710013624746"
data_h = get_personal_data(url)

p data_h



