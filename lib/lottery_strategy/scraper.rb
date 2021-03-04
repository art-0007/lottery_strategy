require 'net/http'
require 'open-uri'
require 'json'

class LotteryStrategy::Scraper

        URL = "https://data.ny.gov/resource/d6yy-54nr.json"
    
    
        def get_results
            uri = URI.parse(URL)
            response = Net::HTTP.get_response(uri)
            results = JSON.parse(response.body)
            #binding.pry
            results
        end



        # def self.scrape_index_page(index_url)
        #     doc = Nokogiri::HTML(open(index_url))
        #     students = []
        #     doc.css("div.student-card").each do |student|
        #       students << {
        #       :name => student.css("h4.student-name").text,
        #       :location => student.css("p.student-location").text,
        #       :profile_url => student.children[1].attributes["href"].value
        #       }
        #     end
        #     students
        #   end
      
      
        def make_draws
            get_results.each {|draw| LotteryStrategy::Draws.new_draws(draw)} 
        end
    end