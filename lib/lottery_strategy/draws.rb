require 'time'

class LotteryStrategy::Draws

    attr_accessor :draw_date, :winning_numbers, :multiplier
  
    @@all = []

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

    def self.all
        @@all
    end

    def self.find_a_draw_by_date(date)
        a = Time.parse(date)
        right_draw = @@all.detect {|draw| draw.draw_date < a }   
    end

    def self.counted_num
        counts = Hash.new(0)
        @@all.each do |arr|
            arr_1 = arr.winning_numbers.first 5
            arr_1.each do |num|
                counts[num] +=1
            end
        end  
        counts 
    end

    def self.lucky_days(days)
        arr = days.split(",")
        arr_1 = []
        arr_2 = []
        arr.each do |el|
            lucky_result = find_a_draw_by_date(el)
            result = lucky_result.winning_numbers.first 5
            arr_1 << result
            arr_2 << lucky_result.winning_numbers.last
        end
        puts "Your lucky numbers: #{arr_1.flatten.shuffle.first 5}, powerball: #{arr_2.shuffle.first} "
    end

    def self.frequently_numbers
        numbers = counted_num.sort_by { |k, v| v }.last 5
        numbers.reverse    
    end

    def self.rarely_numbers
        numbers = counted_num.sort_by { |k, v| v }.first 5
        numbers    
    end
    

end