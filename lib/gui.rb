class Gui
  def initialize()
  end

  def display_board(slots)
    row_one = "\t\t\t\t\t\t#{slots[:one]}|#{slots[:two]}|#{slots[:three]}"
    row_two = "\t\t\t\t\t\t#{slots[:four]}|#{slots[:five]}|#{slots[:six]}"
    row_three = "\t\t\t\t\t\t#{slots[:seven]}|#{slots[:eight]}|#{slots[:nine]}"
    space = "\n"
    [row_one, row_two, row_three, space]
  end

  def msg(msg)
    return msg.each { |m| puts m } if msg.is_a? Array
    puts "\t\t\t\t\t#{msg}"
  end
end

module GameMessages

  def show_winner_msg(player)
    @show_player_win = "Player 🏅 #{player.upcase} 🥇 wins  💰💵 #{player_earnings.to_s.green} 🤑 🏆 ".light_blue
  end
  def show_draw_msg
    @display.msg 'game draw'
  end

  def player_turn_msg(player)
    @display.msg("Player #{player} turn to play enter word ranging from one to nine ".green)
  end

  def turn_error_msg
    @display.msg('please enter word ranging from one to nine or choose another slot'.red)
  end

  def start_msg
    @display.msg "Type start to start Game , S to See Score History or Help for instructions or E to exit game"
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