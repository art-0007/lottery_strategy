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
      
      
        def make_draws
            get_results.each {|draw| LotteryStrategy::Draws.new_draws(draw)} 
        end
    end