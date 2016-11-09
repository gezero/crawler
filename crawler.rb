require 'net/http'
require 'nokogiri'

host = 'www.nhs.uk'

puts "Gathering index urls..."
source = Net::HTTP.get(host , '/Conditions/Pages/hub.aspx')
html = Nokogiri::HTML(source)
urls = html.xpath('//*[@id="haz-mod1"]/ul/li/a/@href').map {|l| "/Conditions/Pages/#{l}"}
urls = [urls.first]

urls.each do |url|
	sleep 1
	puts "Processing #{url}"
	html = Nokogiri::HTML(Net::HTTP.get(host ,url))
	html.xpath('//*[@id="haz-mod5"]/div/div/ul/li').each do |section|
		section_name =  section.xpath('.//a')[0].inner_html
		section_url = section.xpath('.//a/@href')[0]
		exit
	end
end


