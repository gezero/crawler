require 'net/http'
require 'nokogiri'
require 'json'
require './substitutions.rb'

host = 'www.nhs.uk'

puts "Gathering index urls..."
source = Net::HTTP.get(host , '/Conditions/Pages/hub.aspx')
html = Nokogiri::HTML(source)
urls = html.xpath('//*[@id="haz-mod1"]/ul/li/a/@href').map {|l| "/Conditions/Pages/#{l}"}
#urls = [urls.first]

articles=[]

puts "Collecting articles ..."
urls.each do |url|
	sleep 1
	puts "Gathering Articles urls from #{url}"
	html = Nokogiri::HTML(Net::HTTP.get(host ,url))
	html.xpath('//*[@id="haz-mod5"]/div/div/ul/li').each do |section|
        section_name = ""
        section_url = ""
        section.xpath('.//a').each do |element|
            if section_name == ""
                section_name = element.inner_html
                section_url = element.xpath('.//@href')[0].to_s
            end
            article_name =  element.inner_html
            article_url = element.xpath('.//@href')[0].to_s
            puts "#{section_name}/#{article_name} => #{article_url}"
            articles << { :section_name => section_name, :section_url =>section_url,
                        :article_name => article_name, :article_url =>article_url,
                        :host => host}
        end
	end
end

#articles = [articles.first]
puts "Collecting content..."
total =0
articles.each do |a|
    sleep 1
    if (a[:article_url].end_with?("aspx"))
        puts "Gathering content from #{a[:article_url]}"
        html = Nokogiri::HTML(Net::HTTP.get( URI( a[:article_url] )))
        a[:content],count =fix html.xpath("//*[@id='aspnetForm']").xpath(".//div[@class='article']").inner_html.strip!
        total +=count
    else
        puts "Gathering content from #{host}#{a[:article_url]}/Pages/Introduction.aspx"
        html = Nokogiri::HTML(Net::HTTP.get(host ,"#{a[:article_url]}/Pages/Introduction.aspx"))
        a[:content],count = fix html.xpath("//*[@class='main-content healthaz-content clear']").inner_html.strip!
        total +=count
        puts "fixed #{count}" if count>0
    end
    #a[:content] ,count = fix html.xpath("//*[@id='aspnetForm']/div[4]/div[4]/div[1]/div[1]").inner_html.strip!
    #a[:content],count =fix html.xpath("//*//*[@id='aspnetForm']").inner_html.strip!
    #a[:content],count =fix html.xpath("//*[@id="aspnetForm"]/div[3]/div[3]/div[3]/div/div[1]").inner_html.strip!
end

puts "Generating json..."
File.open('content.json','w') do |f|
    f.write(JSON.pretty_generate(articles))
end


