class LotteryStrategy::Scraper

        URL = "https://data.ny.gov/resource/d6yy-54nr.json"
        SITE = "https://www.lotterycritic.com/lottery-winners/the-biggest-lottery-winners-where-are-they-now/"
        NY_LOTTERY = "https://nylottery.ny.gov/how-to-claim"
        
        def get_results
            uri = URI.parse(URL)
            response = Net::HTTP.get_response(uri)
            results = JSON.parse(response.body)
            #binding.pry
            results
        end
# Prepared for new site!
        def self.how_to_claim
            @@claim = Nokogiri::HTML(open(NY_LOTTERY))
            #binding.pry
            puts @@claim.css(".HowToClaim__Description-bmbzfk-8 dXsmkZ").text
        end

        def self.top_5_largest_jackpots
            @@doc = Nokogiri::HTML(open(SITE))
            puts @@doc.css("div section")[1].text
        end
      
      
        def make_draws
            get_results.each {|draw| LotteryStrategy::Draws.new_draws(draw)} 
        end
    end