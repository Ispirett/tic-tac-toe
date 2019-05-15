require "../lib/game_engine"
require "../lib/player"
require_relative '../lib/gui'

class GameManager
  include GameMessages
  include GameEngine
  @@game_count = 0

  def initialize(d, game_over = false)
    @game_over = game_over
    @display = d
    @@game_count += 1
  end

  def game_start
    info
  end

  def game_update(game_over = @game_over)
    @game_over = game_over
    game_end if @game_over
  end

  def player_info
    @display.msg("Player (1) Enter your name".red)
    player_one = gets.chomp
    p1 = Player.new(player_one, player_wager)

    @display.msg("Player (2) Enter your name".light_blue)
    player_two = gets.chomp
    p2 = Player.new(player_two,player_wager )
    [p1, p2]
  end


  private
  def player_wager
    @display.msg("Player  enter bet amount".yellow )
    bet = gets.chomp
    if bet.to_i == 0
      player_wager
    end
    bet.to_i
  end

  def game_end
    @display.msg "Thanks for Playing".red
    game_start
  end

  def info
    @display.msg "Type start to start Game , S to See Score History or Help for instructions or E to exit game".bg_red
    input = gets.chomp
    case true
    when input.casecmp("s").zero?
      open_file
      info
    when input.casecmp("start").zero?
      player_info
    when input.casecmp("help").zero?
      instructions
      info
    when input.casecmp("e").zero?
      exit
    else
      info
    end
  end

end
