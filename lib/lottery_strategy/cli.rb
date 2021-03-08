class LotteryStrategy::CLI
    attr_accessor :user, :users, :board, :strategy_preferences, :lucky_days
    attr_reader :rarely_numbers, :frequently_numbers, :long_standing_numbers

    def call
        LotteryStrategy::Scraper.new.make_draws
        list_draws
        menu
        goodbuy
    end

    def list_draws
puts <<-RAVEN
Welcome to the best lottery strategy!!! Do you like to play a games? If you are ready to put our
 methods to the test, go ahead to create your own strategies. Choose your way through our list:  
    RAVEN
        
        puts "      To see the Biggest Powerball USA Winners, enter '1'.".colorize(:light_blue)
        puts "____________________________________________________________________________".colorize(:yellow)
        puts "      #1. For create your own account or find an existing one, enter '2'.".colorize(:green)
        puts "      #2. For see your strategy Board, enter '3'.".colorize(:green)
        puts "      #3. For change your stretegy preferences, enter '4'.".colorize(:green)
        puts "____________________________________________________________________________".colorize(:yellow)
        puts "      Enter '5' for more info about strategies.".colorize(:green)
        puts "      If you'd like to see a winning numbers by closest date, enter '6'.".colorize(:green)
        puts "      For check your ticket, enter '7'.".colorize(:green)
        puts "      To quit, type 'exit'.".colorize(:green)
          
    end


    def new_user

        input = nil
        puts "Welcome to the best lottery strategy!!! Please enter your name:".colorize(:light_blue)
        input  = gets.strip.downcase
        LotteryStrategy::Board.find_or_create_by_name(input)
        menu
   
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
                new_user
            when "3"
                puts "Have you created your strategy preferances by using #4?"
                input  = gets.strip.downcase
                    case input
                    when "y"   
                    LotteryStrategy::Board.display
                    else
                    puts "Please enter #4 for add your strategy preferances first"
                    end
            when "4"
                puts "For our lucky days method please enter your 3 lucky dates in format: yyyy-mm-dd,yyyy-mm-dd,yyyy-mm-dd".colorize(:light_blue)
                input  = gets.strip.downcase
                arr = input.split(/,\s|,|\s/)
                result = arr.detect {|date| (rigth_date(date) && valid_date(date)) == false}
                if result == nil
                LotteryStrategy::Board.add_lucky_days(input)
                puts "STRATEGY LIST"
                puts "For rarely dropped numbers strategy, enter 1.".colorize(:green)
                puts "For frequently dropped numbers strategy, enter 2.".colorize(:green)
                puts "For long-standing numbers strategy, enter 3.".colorize(:green)
                puts "For your lucky days strategy, enter 4.".colorize(:green)
                puts "For mix strategy enter the number of your shoosen strategy (1-4) to every single ticket number and powerball(last number) in format: X X X X X X."
                end
                input  = gets.strip.downcase
                if valid_strategy_numbers(input.split(' '))
                LotteryStrategy::Board.add_strategy_preferences(input)
                end
            when "5"
                puts "_________________________________________________________________________________________________________________________________________".colorize(:yellow)
                puts "In our programm we have been processing over 1000 NY Powerball data draws since 2011. We are building our strategies by using that data.".colorize(:light_blue)
                puts "We do not impose our strategies on you. We just provide you with a data analysis tool. The decisions you make yourself!".colorize(:light_blue)
                puts "We provide you with a strategy board with which you can choose the outcome you like.".colorize(:light_blue)
                puts "For rarely dropped numbers strategy we calculate Which numbers were drawn the least often over the past 10 years.".colorize(:light_blue)
                puts "For frequently dropped numbers strategy we calculate Which numbers were drawn the often over the past 10 years.".colorize(:light_blue)
                puts "For lucky days strategy we calculate which numbers dropped out in  your Happy days and use these numbers.".colorize(:light_blue)
                puts "For mix strategy we apply our strategy for each individual ticket number including the powerball.".colorize(:light_blue)
                puts "__________________________________________________________________________________________________________________________________________".colorize(:yellow)

            when "6"
                puts "Enter the date you'd like to check in format: yyyy-mm-dd".colorize(:light_blue)
                input  = gets.strip.downcase
                    if valid_date(input) && rigth_date(input)
                    closest_draw = LotteryStrategy::Draws.find_a_draw_by_date(input)
                    puts "closest date: #{closest_draw.draw_date.strftime("%m/%d/%Y")}, winning numbers: #{closest_draw.winning_numbers.first 5}, powerball: #{closest_draw.winning_numbers.last}".colorize(:light_blue)
                    else
                    puts "Please check your input format".colorize(:red) 
                    end
            when "7"
                puts "For check your ticket enter numbers, powerball, and date in the following format: X X X X X X, yyyy-mm-dd."
                input  = gets.strip.downcase
                input_array = input.split(",")
                numbers = input_array[0].split(' ')
                date = input_array[1]
                    if (valid_lottery_numbers(numbers.first(5)) && valid_powerball_number(numbers.last) && valid_date(date) && rigth_date(date)) == true
                    matches = LotteryStrategy::Draws.check_your_ticket(input)
                    else
                    puts "Please check your input format".colorize(:red)  
                    end  
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
        puts "See you next time for more games!!!".colorize(:green)   
    end


    def rigth_date(date)
        if  !valid_date(date)
            false
        elsif Date.parse("2011-08-01")  < Date.parse(date) && Date.parse(date) < Date.today
        true
        else
        false
        end
    end

    def valid_date(date_string)
        begin
            Date.parse(date_string)
            true
          rescue ArgumentError
            false
        end
    end

    def valid_strategy_numbers(players_input)
        result = players_input.detect {|num| (1 <= num.to_i && num.to_i <= 4) == false}
        if result == nil
            true
        else
            false
        end
    end

    def valid_lottery_numbers(players_input)
        result = players_input.detect {|num| (1 <= num.to_i && num.to_i <= 69) == false}
        if result == nil
            true
        else
            false
        end
    end

    def valid_powerball_number(num)
        
        if 1 <= num.to_i && num.to_i <= 26
            true
        else
            false
        end
    end


      
end