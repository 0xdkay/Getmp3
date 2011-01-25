require 'mechanize'
require 'open-uri'
t = Mechanize.new
t2 = t.get("http://www.pbs.org/newshour/newshour_index.html")
t3 = t2.body.scan(/<a href="(http:\/\/[\.\w\d\/\-\_]+\.mp3)" /).uniq
file_name = []
t3.each do |v| 
	v.each do |j| 
	#	tmp = Mechanize.new
		file_name.push($1) if j.scan(/\/([\w\d\-\_]+)\.mp3/)
	#	tmp.get(j).save_as($1+".mp3")
	end
end

t4 = t2.body.scan(/<a href='(http:\/\/[\.\w\d\/\-\_]+\.html)'/).uniq

i=0
t4.map do |v| 
	tmp = t.get(v[0]).search('//div[@class="copy"]/p/text() | //div[@class="copy"]/p/strong/text()')
	open(file_name[i]+"_script.txt","w") {|f| f.puts(tmp)}
	i += 1
end
