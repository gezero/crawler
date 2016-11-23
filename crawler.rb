require 'net/http'
require 'nokogiri'
require 'json'

host = 'www.nhs.uk'

puts "Gathering index urls..."
source = Net::HTTP.get(host , '/Conditions/Pages/hub.aspx')
html = Nokogiri::HTML(source)
urls = html.xpath('//*[@id="haz-mod1"]/ul/li/a/@href').map {|l| "/Conditions/Pages/#{l}"}
urls = [urls.first]

articles=[]

puts "Collecting articles ..."
urls.each do |url|
	sleep 1
	puts "Gathering Articles urls from #{url}"
	html = Nokogiri::HTML(Net::HTTP.get(host ,url))
	html.xpath('//*[@id="haz-mod5"]/div/div/ul/li')[0..1].each do |section|
        section_name = ""
        section_url = ""
        section.xpath('.//a').each do |element|
            if section_name == ""
                section_name = element.inner_html
                section_url = element.xpath('.//@href')[0]
            end
            article_name =  element.inner_html
            article_url = element.xpath('.//@href')[0]
            puts "#{section_name}/#{article_name} => #{article_url}"
            articles << { :section_name => section_name, :section_url =>section_url,
                        :article_name => article_name, :article_url =>article_url}
        end
	end
end

#articles = [articles.first]
puts "Collecting content..."

articles.each do |a|
    puts "Gathering content from #{a[:article_url]}/Pages/Introduction.aspx"
    html = Nokogiri::HTML(Net::HTTP.get(host ,"#{a[:article_url]}/Pages/Introduction.aspx"))
    a[:content] = html.xpath("//*[@id='aspnetForm']/div[4]/div[4]/div[1]/div[1]").inner_html.strip!
end

File.open('content.json','w') do |f|
    f.write(JSON.pretty_generate(articles))
end


