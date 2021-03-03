require 'colorize'
require 'pry'
class LotteryStrategy::CLI

    def call
        #binding.pry
        LotteryStrategy::Scraper.new.make_draws 
        #binding.pry
        list_draws
        menu
        goodbuy
    end

    def list_draws
puts <<-RAVEN
Welcome to the best lottery strategy!!! Do you like to play a games? If you are ready
to put our methods to the test, go ahead and choose your way through our list.  
    RAVEN
        
        puts "      First to see the Biggest Lottery Winners, enter '1'.".colorize(:light_blue)
        puts "      Next choose your own strategy from the list:".colorize(:light_blue)
        puts "____________________________________________________________________________".colorize(:yellow)
        puts "      #1. rarely dropped numbers, enter '2'.".colorize(:green)
        puts "      #2. frequently dropped numbers, enter '3'.".colorize(:green)
        puts "      #3. long-standing numbers, enter '4'.".colorize(:green)
        puts "      #4. your lucky days, enter '5'.".colorize(:green)
        puts "      #5. mix strategy, enter '6'.".colorize(:green)
        puts "____________________________________________________________________________".colorize(:yellow)
        puts "      Enter '6' for more info about strategies.".colorize(:green)
        puts "      If you'd like to see a winning numbers by closest date, enter '7'.".colorize(:green)
        puts "      For check your ticket, enter '8'.".colorize(:green)
        puts "      To quit, type 'exit'.".colorize(:green)
          
    end

    def menu

    input = nil
    while input != "exit"
        puts "Enter the number from the list or type list or exit".colorize(:light_blue)
        input  = gets.strip.downcase
        case input
            when "1"
                puts "option 1"
            when "2"
                rarely_numbers = LotteryStrategy::Draws.rarely_numbers
                puts "rarely numbers: #{rarely_numbers.to_h}"
            when "3"
                frequently_numbers = LotteryStrategy::Draws.frequently_numbers
                puts "frequently numbers: #{frequently_numbers.to_h}"
            when "4"
                puts "option 4"
            when "5"
                puts "option 5"
            when "6"
                puts "option 6"
            when "7"
            puts "Enter the date you'd like to check in format yyyy-mm-dd".colorize(:light_blue)
            input  = gets.strip.downcase
            right_draw = LotteryStrategy::Draws.find_a_draw_by_date(input)
            right_draw
            when "8"
            puts "option 2"
            when "list"
            list_draws
            else
            puts "Not sure what you want, type list or exit".colorize(:red)
        end
    end
end
        
    def goodbuy
        puts "See you next draw for more deals!!!".colorize(:green)   
    end


      
end