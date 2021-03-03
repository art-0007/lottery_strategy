require 'time'

class LotteryStrategy::Draws

    attr_accessor :draw_date, :winning_numbers, :multiplier
  
    @@all = []

    # def self.draws
    #     puts "Hello! Do you like to play a games? These are the Biggest Lottery Winners:".colorize(:light_blue)
    #     puts "____________________________________________________________________________".colorize(:yellow)

    #     puts "1. Top 5 players in Powerball USA     2. Top 5 players in Mega Millions USA".colorize(:green)
    #     puts "____________________________________________________________________________".colorize(:yellow)
        
    #  end
  
    def self.new_draws(hash)
         self.new(Time.parse(hash["draw_date"]), hash["winning_numbers"].split(" ").map(&:to_i), hash["multiplier"].to_i)
         #binding.pry   
    end
  
    def initialize(draw_date, winning_numbers = [], multiplier = nil)
      @draw_date = draw_date
      @winning_numbers = winning_numbers
      @multiplier = multiplier
      @@all << self
    end

    def self.find_a_draw_by_date(date)
        a = Time.parse(date)
        right_draw = @@all.detect {|draw| draw.draw_date < a }
        puts "closest date: #{right_draw.draw_date.strftime("%m/%d/%Y")}, winning numbers: #{right_draw.winning_numbers.first 5}, powerball: #{right_draw.winning_numbers.last}".colorize(:light_blue)    
    end
    
  
    def self.all
      @@all
    end
  
    # def self.find(id)
    #   self.all[id-1]
    # end
end