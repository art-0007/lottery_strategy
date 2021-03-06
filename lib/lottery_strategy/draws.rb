class LotteryStrategy::Draws

    attr_accessor :draw_date, :winning_numbers, :multiplier
  
    @@all = []

    def self.new_draws(hash)
         self.new(Time.parse(hash["draw_date"]), hash["winning_numbers"].split(" ").map(&:to_i), hash["multiplier"].to_i)   
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

    def self.long_standing_numbers
    array = Array(1..69)
    @@all.each do |arr|
        win_num_5 = arr.winning_numbers.first 5
        win_num_5.each do |num|
            if array.length<=5
            break
            else
            array.delete(num) 
            end
        end
    end
    array
    end

    def self.long_standing_powerball
        array = Array(1..26)
        @@all.each do |arr|
            powerball = arr.winning_numbers.last
                if array.length==1
                break
                else
                array.delete(powerball) 
                end
        end
        array
    end

    def self.find_a_draw_by_date(date)
        a = Time.parse(date)
        right_draw = @@all.detect {|draw| draw.draw_date <= a }   
    end

    def self.check_your_ticket(input)
        ticket = input.split(",")               
        draw = find_a_draw_by_date(ticket.last)
        result_numbers = draw.winning_numbers
        winning_powerball = result_numbers.last
        winning_numbers = result_numbers.first 5
        player_numbers = ticket[0].split(" ").map{|x| x.to_i}
        player_powerball = ticket[1].to_i
        your_matches =  player_numbers&winning_numbers
       if winning_powerball == player_powerball
        puts "You guessed the powerball!".colorize(:light_blue)
       else
        puts "Your powerball doesn't match.".colorize(:light_blue)
       end 
       puts "Your numbers matches: #{your_matches}".colorize(:light_blue)
       puts "____________________________________________________________________________".colorize(:yellow)
       puts "Winning numbers: #{winning_numbers}, powerball: #{winning_powerball} for date: #{draw.draw_date.strftime("%m/%d/%Y")}".colorize(:light_blue)
       puts "____________________________________________________________________________".colorize(:yellow)  
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

    def self.mix_strategy(players_choose)
        #binding.pry
        strategy = players_choose.split(", ")
        ticket = []
        array = strategy[0].split(" ")
        counts = Hash.new(0)
        array.each {|x| counts[x] += 1}
        #while ticket.flatten.length != 6 do
            n = counts["1"]
            ticket  << rarely_numbers.to_h.keys.shuffle.first(n)
            n = counts["2"]
            ticket  << frequently_numbers.to_h.keys.shuffle.first(n)
            n = counts["3"]
            ticket  << long_standing_numbers.shuffle.first(n)
            if counts["4"] != 0
            n = counts["4"]
            draw = find_a_draw_by_date(strategy[1])
            ticket << draw.winning_numbers.shuffle.first(n)
            end
            #ticket.flatten.uniq
        #end
        ticket.flatten   
    end

    def self.valid_numbers(strategy_mix_input)
        #binding.pry
        array = strategy_mix_input.split(", ")[0].split(" ")
        valid_num = ["1","2","3","4"]
        if array.detect {|num| !valid_num.include?(num)} == nil
            true
        else
            false
        end   
    end

    def self.valid_date(date_string_input)
        if date_string_input.split(", ").length == 2
        date_string= date_string_input.split(", ")[1]
        begin
            Date.parse(date_string)
            true
          rescue ArgumentError
            false
          end
        else
            false
        end   
    end
    

end