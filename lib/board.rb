require_relative  "game_engine"
require_relative 'gui'

class Board
  include GameEngine
  include GameMessages
  MAX_TURNS = 9
  attr_reader :is_game_over
  def initialize(p1, p2, d, game_manager)
    @display = d
    @game_manager = game_manager
    @player_one = p1 # player one object
    @player_two = p2 # player two object
    @player_one.icon = 'X'.red
    @player_two.icon = 'O'.light_blue
    @is_game_over = false
    @update = false
    @slots = {
        one: '__',
        two: '__',
        three: '__',
        four: '__',
        five: '__',
        six: '__',
        seven: '  ',
        eight: '  ',
        nine: '    '
    }
    @current_turn = MAX_TURNS
  end

  private
  def game_over?
      win_or_draw_check

    if @is_game_over
      show_winner_msg(player_select.name, player_earnings)
      create_or_append_file([
      "Player 🏅 #{player_select.name.upcase} 🥇 wins  💰💵 #{player_earnings.to_s.green} 🤑 🏆 ".light_blue,
       @display.display_board(@slots), Time.now])
    end
  end

  def player_select
    return @player_one unless @current_turn.even?

    @player_two if @current_turn.even?
  end

  def can_board_update?
    player_turn_msg(player_select.name)
    player_slot_input = gets.chomp


    if !@slots.key?(player_slot_input.to_sym) ||
        @slots[player_slot_input.to_sym] == @player_one.icon + ' ' ||
        @slots[player_slot_input.to_sym] == @player_two.icon + ' '
        # checks to see if player input matches any key
      turn_error_msg
      @update = false
    else
      @slots[player_slot_input.to_sym] = player_select.icon + ' '
      game_over?
      @display.msg(@display.display_board(@slots))
      @update = true
    end

  end
  
  def turn_update
    if @update == true
      @current_turn -= 1
      show_current_turn_msg(@current_turn)
    end
  end

  def update_board
    can_board_update?
    turn_update
  end


  def player_earnings
     @player_one.bet_amount + @player_two.bet_amount
  end


  def win_or_draw_check
    win_x = ->(n) { n == "#{@player_one.icon} " }
    win_o = ->(n) { n == "#{@player_two.icon} " }
    # conditions
    cases =  [
        [@slots[:one], @slots[:two], @slots[:three]],
        [@slots[:four], @slots[:five], @slots[:six]],
        [@slots[:seven], @slots[:eight], @slots[:nine]],
        [@slots[:one], @slots[:four], @slots[:seven]],
        [@slots[:two], @slots[:five], @slots[:eight]],
        [@slots[:three], @slots[:six], @slots[:nine]],
        [@slots[:one], @slots[:five], @slots[:nine]],
        [@slots[:three], @slots[:five], @slots[:seven]]
    ]

    cases.each do |i|
      @is_game_over = true  if i.all?(win_x) || i.all?(win_o)
      show_draw_msg if @current_turn == 0
    end
  end

public
  def game_loop
    while @current_turn > 0 && !@is_game_over
        update_board
        @game_manager.game_update(@is_game_over)
    end
  end
end
