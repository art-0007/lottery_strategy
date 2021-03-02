require 'colorize'
class LotteryStrategy::CLI

    def call
        #binding.pry
        #LotteryStrategy::Scraper.new.make_draws 
        list_draws
        menu
        goodbuy
    end

    def list_draws
        puts "Hello! Do you like to play a games? These are the Biggest Lottery Winners:".colorize(:light_blue)
        puts "____________________________________________________________________________".colorize(:yellow)

        puts "1. Top 5 players in Powerball USA     2. Top 5 players in Mega Millions USA".colorize(:green)
        puts "____________________________________________________________________________".colorize(:yellow)
    end

    def menu

    input = nil
    while input != "exit"
        puts "Enter the number of the deal you'd like more info on or type list or exit"
        input  = gets.strip.downcase
        case input
        when "1"
            puts "option 1"
        when "2"
            puts "option 2"
        when "list"
            list_draws
        else
            puts "Not sure what you want, type list or exit"
        end
    end
end
        
    def goodbuy
        puts "See you next draw for more deals!!!"   
    end


      
end