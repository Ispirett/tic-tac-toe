require_relative  "game_engine"
require_relative  "player"
require_relative 'gui'

class GameManager
  include GameMessages
  include GameEngine
  attr_accessor :game_loop
  def initialize(d, game_over = false)
    @game_over = game_over
    @display = d
    @game_loop = true
  end

  def game_init
    info
  end

  def game_start
    player_info
  end


  def game_update(game_over = @game_over)
    @game_over = game_over
    game_end if @game_over
  end

  def player_info
    enter_player_name_msg(1)
    player_one = gets.chomp
    p1 = Player.new(player_one, player_wager)

    enter_player_name_msg(2)
    player_two = gets.chomp
    p2 = Player.new(player_two,player_wager )
    [p1, p2]
  end


  private
  def player_wager
    show_bet_msg
    bet = gets.chomp
    if bet.to_i == 0
      player_wager
    end
    bet.to_i
  end

  def game_end
    show_end_msg
  end

  def info
    show_start_msg
    input = gets.chomp
    case true
    when input.casecmp("s").zero?
      open_file
      info
    when input.casecmp("start").zero?
      game_start
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
