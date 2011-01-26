require 'mechanize'
require 'open-uri'
t = Mechanize.new
t2 = t.get("http://www.pbs.org/newshour/newshour_index.html")
t3 = t2.body.scan(/<a href=['"](http:\/\/[\.\w\d\/\-\_]+\.html)['"]/i).uniq

d = Dir.new(Dir.pwd).to_a

t3.map do |v| 
	tmp = t.get(v[0])
	scf = tmp.search('//div[@class="copy"]/p/text() | //div[@class="copy"]/p/strong/text()')
        mp3f = tmp.search('//div[@class="mp3"]//p/a').to_s.scan(/http:\/\/[\w\-\.\/]+mp3/)
	if not mp3f.empty? and mp3f[0] =~ /\/([\w\d\-\_]+)\.mp3/i
		scriptname = $1+"_script.txt"
		mp3name = $1+".mp3"
		dirname = $1.gsub(/\_[\w\d]+/i,'')
		begin
			d = Dir.new(Dir.pwd+"/#{dirname}").to_a
		rescue
			%x[mkdir #{dirname}]
			d = Dir.new(Dir.pwd+"/#{dirname}").to_a
		end
		t.get(mp3f[0]).save_as(File.join(dirname,mp3name)) if not d.index(mp3name)
		open(File.join(dirname,scriptname),"w") {|f| f.puts(scf)} if not d.index(scriptname)
	end
end
