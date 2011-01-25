require 'mechanize'
require 'open-uri'
t = Mechanize.new
t2 = t.get("http://www.pbs.org/newshour/newshour_index.html")
t3 = t2.body.scan(/<a href="(http:\/\/[\.\w\d\/\-\_]+\.mp3)" /).uniq
file_name = t3.map {|v| v.map {|j| j.scan(/\/([\w\d\-\_]+)\.mp3/)}}

