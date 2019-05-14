require_relative  "../lib/game_engine"
require_relative '../lib/gui'

class Board
  include GameEngine
  include GameMessages
  def initialize(p1, p2, d, game_manager)
    @display = d
    @game_manager = game_manager
    @player_one = p1 # player one object
    @player_two = p2 # player two object
    @player_one.icon = 'X'.red
    @player_two.icon = 'O'.light_blue
    @is_game_over = false
    @update = false
    @show_player_win = ''
    @show_game_draw = ''
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
    @current_turn = 9
  end

  private
  def game_over?
      win_or_draw_check
      show_winner_msg(player_select.name)

    if @is_game_over
      create_or_append_file([show_winner_msg(player_select.name),
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

    if !@slots.key?(player_slot_input.to_sym) # checks to see if player input matches any key
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
      @display.msg "Turn #{@current_turn}  \n".yellow
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
    one = [@slots[:one], @slots[:two], @slots[:three]]
    two = [@slots[:four], @slots[:five], @slots[:six]]
    three = [@slots[:seven], @slots[:eight], @slots[:nine]]
    four = [@slots[:one], @slots[:four], @slots[:seven]]
    five = [@slots[:two], @slots[:five], @slots[:eight]]
    six = [@slots[:three], @slots[:six], @slots[:nine]]
    seven  = [@slots[:one], @slots[:five], @slots[:nine]]
    eight  = [@slots[:three], @slots[:five], @slots[:seven]]

    case true
    when one.all?(win_x) || one.all?(win_o) || two.all?(win_x) || two.all?(win_o) ||
      three.all?(win_x) || three.all?(win_o)
      show_winner_msg(player_select.name)
      @is_game_over = true

    when four.all?(&win_x) || four.all?(&win_o) || five.all?(&win_x) || five.all?(&win_o)
        @display.msg(@show_player_win)
        show_winner_msg(player_select.name)
        @is_game_over = true

    when six.all?(&win_x) || six.all?(&win_o) ||
        seven.all?(&win_x) || seven.all?(&win_o) || eight.all?(&win_x) || eight.all?(&win_o)
        show_winner_msg(player_select.name)
        @is_game_over = true

    else
      show_draw_msg
    end
  end

public
  def game_loop
    while @current_turn > 0
      update_board
      @game_manager.game_update(@is_game_over)
    end
  end



end
