class LotteryStrategy::Board
    attr_accessor :user, :board, :strategy_preferences, :lucky_days
    attr_reader :rarely_numbers, :frequently_numbers, :long_standing_numbers, :long_standing_powerball
    @@all = []
    @users = []

    def initialize (user)
    @@board = self
    @user = user
    @strategy_preferences = []
    @lucky_days = []
    @rarely_numbers = LotteryStrategy::Draws.rarely_numbers.to_h
    @frequently_numbers = LotteryStrategy::Draws.frequently_numbers.to_h
    @long_standing_numbers = LotteryStrategy::Draws.long_standing_numbers
    @long_standing_powerball = LotteryStrategy::Draws.long_standing_powerball
    end

    def self.add_strategy_preferences(input_strategy_preferences)
        @@board.strategy_preferences = input_strategy_preferences.split(/,\s|,|\s/)   
    end

    def self.add_lucky_days(input_lucky_days)
        @@board.lucky_days = input_lucky_days.split(/,\s|,|\s/)    
    end

    def self.all
    @@all
    end

    def self.board
        @@board
    end

    def self.display
            
        lucky_days_numbers = LotteryStrategy::Draws.find_num_by_lucky_days(board.lucky_days)
        mix_strategy = LotteryStrategy::Draws.mix_strategy(board.strategy_preferences, board.lucky_days)
        puts "____________________________________________________________________________".colorize(:yellow)
        puts "User-name: #{board.user}".colorize(:green)
        puts "User strategy preferences: #{board.strategy_preferences}".colorize(:green)
        puts "User lucky days: #{board.lucky_days}".colorize(:green)
        puts "____________________________________________________________________________".colorize(:yellow)
        puts "Strategic combinations:"
        puts "  |   1.Rarely dropped numbers: #{board.rarely_numbers}         |".colorize(:light_blue)
        puts "  |   2.Frequently dropped numbers: #{board.frequently_numbers}    |".colorize(:light_blue)
        puts "  |   3.Long-standing numbers: #{board.long_standing_numbers}, powerball: #{board.long_standing_powerball}|".colorize(:light_blue)
        puts "  |   4.User lucky days numbers: #{lucky_days_numbers}                     |".colorize(:light_blue)
        puts "  |   5.User mix strategy numbers: #{mix_strategy}                      |".colorize(:light_blue)
        puts "____________________________________________________________________________".colorize(:yellow)

    end

    def save
        self.class.all << self
    end
    
    def self.destroy_all
        @@all.clear 
    end
    
    def self.create_by_name(name)
        new(name).save
    end

    def self.find_or_create_by_name(name)
        user_name = @users.detect{|x| x.name == name}
        if user_name == nil
          self.create_by_name(name)
        else
            user_name
        end
    end
    
    

end