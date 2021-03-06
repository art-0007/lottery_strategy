class LotteryStrategy::CLI

    def call
        LotteryStrategy::Scraper.new.make_draws
        
        #LotteryStrategy::Scraper.how_to_claim
        list_draws
        menu
        goodbuy
    end

    def list_draws
puts <<-RAVEN
Welcome to the best lottery strategy!!! Do you like to play a games? If you are ready
to put our methods to the test, go ahead and choose your way through our list.  
    RAVEN
        
        puts "      To see the Biggest Powerball USA Winners, enter '1'.".colorize(:light_blue)
        puts "      Next choose your own strategy from the list:".colorize(:light_blue)
        puts "____________________________________________________________________________".colorize(:yellow)
        puts "      #1. rarely dropped numbers, enter '2'.".colorize(:green)
        puts "      #2. frequently dropped numbers, enter '3'.".colorize(:green)
        puts "      #3. long-standing numbers, enter '4'.".colorize(:green)
        puts "      #4. your lucky days, enter '5'.".colorize(:green)
        puts "      #5. mix strategy, enter '6'.".colorize(:green)
        puts "____________________________________________________________________________".colorize(:yellow)
        puts "      Enter '7' for more info about strategies.".colorize(:green)
        puts "      If you'd like to see a winning numbers by closest date, enter '8'.".colorize(:green)
        puts "      For check your ticket, enter '9'.".colorize(:green)
        puts "      To quit, type 'exit'.".colorize(:green)
          
    end

    def mix_strategy_call
        input = nil
        while input != "exit"
        puts <<-RAVEN
For create your own lottery ticket please enter the number of your shoosen strategy (1-4)
to every single ticket number and powerball(last number) and date if your choose include
strategy #4(if not don't fill it) in format: X X X X X X, yyyy-mm-dd
    RAVEN
    puts "____________________________________________________________________________".colorize(:yellow)
    puts "STRATEGY LIST"
    puts "For rarely dropped numbers strategy, enter 1.".colorize(:green)
    puts "For frequently dropped numbers strategy, enter 2.".colorize(:green)
    puts "For long-standing numbers strategy, enter 3.".colorize(:green)
    puts "For your lucky days strategy, enter 4.".colorize(:green)
    puts "____________________________________________________________________________".colorize(:yellow)
        input  = gets.strip.downcase
        valid_input(input)
        input = "exit"
        end
    end
        

    def menu

        input = nil
        while input != "exit"
        puts "Enter the number from the list or type list or exit".colorize(:light_blue)
        input  = gets.strip.downcase
        case input
            when "1"
                LotteryStrategy::Scraper.top_5_largest_jackpots
            when "2"
                rarely_numbers = LotteryStrategy::Draws.rarely_numbers
                puts "rarely numbers: #{rarely_numbers.to_h}".colorize(:light_blue)
            when "3"
                frequently_numbers = LotteryStrategy::Draws.frequently_numbers
                puts "frequently numbers: #{frequently_numbers.to_h}".colorize(:light_blue)
            when "4"
                long_standing_powerball = LotteryStrategy::Draws.long_standing_powerball
                long_standing_numbers = LotteryStrategy::Draws.long_standing_numbers
                puts "long-standing numbers: #{long_standing_numbers}, long-standing powerball: #{long_standing_powerball[0]}".colorize(:light_blue)
            when "5"
                puts "For our lucky days method please enter your 5 lucky dates in format: yyyy-mm-dd,yyyy-mm-dd,yyyy-mm-dd,yyyy-mm-dd,yyyy-mm-dd".colorize(:light_blue)
            input  = gets.strip.downcase
            lucky_draw = LotteryStrategy::Draws.lucky_days(input)
            lucky_draw
            when "6"
                mix_strategy_call
                #binding.pry
            when "7"
                puts "option 7 more info about strategies"
            when "8"
            puts "Enter the date you'd like to check in format: yyyy-mm-dd".colorize(:light_blue)
            input  = gets.strip.downcase
            closest_draw = LotteryStrategy::Draws.find_a_draw_by_date(input)
            puts "closest date: #{closest_draw.draw_date.strftime("%m/%d/%Y")}, winning numbers: #{closest_draw.winning_numbers.first 5}, powerball: #{closest_draw.winning_numbers.last}".colorize(:light_blue)
            when "9"
            puts "For check your ticket enter numbers, powerball, and date in the following format: X X X X X, X, yyyy-mm-dd."
            input  = gets.strip.downcase
            matches = LotteryStrategy::Draws.check_your_ticket(input)
            when "list"
            list_draws
            when "exit"
            "exit"
            else
            puts "Not sure what you want, type list or exit".colorize(:red)
        end
    end
end
        
    def goodbuy
        puts "See you next draw for more deals!!!".colorize(:green)   
    end

    def valid_input(input)
        if LotteryStrategy::Draws.valid_numbers(input) &&  LotteryStrategy::Draws.valid_date(input)
            ticket = LotteryStrategy::Draws.mix_strategy(input)
            puts "Your strategy choose: for #1: strategy #{input.split(/,\s|\s/)[0]},for #2: strategy #{input.split(/,\s|\s/)[1]},for #3: strategy #{input.split(/,\s|\s/)[2]},for #4: strategy #{input.split(/,\s|\s/)[3]},for #5: strategy #{input.split(/,\s|\s/)[5]}, for powerball:  strategy #{input.split(/,\s|\s/)[6]}! " 
            puts "Your ticket numbers: #{ticket[0..-2]}, long-standing powerball: #{ticket.last}".colorize(:light_blue)
            else
            puts "Not sure what you want, type list or exit".colorize(:red)
            end
            #binding.pry
            ticket
    end


      
end