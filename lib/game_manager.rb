require "../lib/game_engine"
require "../lib/player"

class GameManager
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

  def instructions
    @display.msg [
                   "               ___________________________________________________________________________________ \n",
                   "                       ****************************************************************              ".green,
                   "                             Welcome to TicTacToe Created By Ispirett And Armando".light_blue,
                   "                       ****************************************************************              ".green,
                   "               Rules of the game are as follows".yellow,
                   "                   * The game is made up of a 3X3 grid three rows three columns".pink,
                   "                   * Each player is assigned an icon {X} or {O} ".light_blue,
                   "                   * Two players take turns attempting to get three icons in a row Horizontally, Vertically or diagonally ".pink,
                   "                   * First player to get three icons in a row wins.".pink,
                   "                   * The game is a draw if there are no empty slots and neither player has gotten three icons in row".light_blue,
                   "                ___________________________________________________________________________________ \n",

                 ]
  end
end
