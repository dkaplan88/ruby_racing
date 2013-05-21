require_relative 'utilities'
 
class RubyRacer
  attr_reader :players, :length
 
  def initialize(players, length = 30)
    @players = players
    @length = length
    @position = Hash.new
    
    players.each_with_index do |player, index|
      @position[players[index]] = 0
    end
  end

  def finished?
    @position[players[0]] >= @length || @position[players[1]] >= @length
  end

  def advance_player(player)
    roll = Die.new.roll
    reputs "#{player} rolled a #{roll}"
    sleep(0.8)
    return @position[player] += roll if @position[player] <= @length
    return @position[player] = @length
  end

  def winner
    @position[players[0]] > @position[players[1]] ? players[0] : players[1]
  end

  def print_board
    board

    until finished?
      play_game
    end

    p "#{self.winner} is the winner"
  end

  def board
    move_to_home! && clear_screen! 

    @position.each do |key, value|
      if value == 0
        reputs "#{key}   |" + ('    |'  * (@length - 1)) 
      elsif winner == key && finished?
        reputs '    |'  * @length + key.to_s 
      else
        reputs ('    |' * (value)) + "#{key}   |" + ('    |' * (@length - value - 1))
      end
    end

    sleep(0.5) unless finished?
  end

  def play_game
    @players.each do |player|
      advance_player(player)
      return board if finished?
      board
    end
  end
end
 
players = ['a', 'b']
 
game = RubyRacer.new(players)
clear_screen!
game.print_board

