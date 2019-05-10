require "../lib/game_engine"

class Board
  include GameEngine
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


  def game_over?(_name = 'player')
    @show_player_win = "Player 🏅 #{player_select.name.upcase} 🥇 wins 🏆 ".light_blue
    @show_game_draw = 'game draw' if @current_turn == 1
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
      @display.msg(@show_player_win)
      @is_game_over = true

    when four.all?(&win_x) || four.all?(&win_o) || five.all?(&win_x) || five.all?(&win_o)
      @display.msg(@show_player_win)
      @is_game_over = true

    when six.all?(&win_x) || six.all?(&win_o) ||
        seven.all?(&win_x) || seven.all?(&win_o) || eight.all?(&win_x) || eight.all?(&win_o)
      @display.msg(@show_player_win)
      @is_game_over = true

    else
      puts @show_game_draw
    end

    if @is_game_over
      create_or_append_file(@show_player_win)
      create_or_append_file(@display.display_board(@slots))
    end
  end

  def player_select
    return @player_one unless @current_turn.even?

    @player_two if @current_turn.even?
  end

  def can_board_update?
    @display.msg("Player #{player_select.name} turn to play enter word ranging from one to nine ".green)
    player_slot_input = gets.chomp

    if @slots.key?(player_slot_input.to_sym) == false # checks to see if player input matches any key

      @display.msg('please enter word ranging from one to nine or choose another slot'.red)
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


  def game_loop
    while @current_turn > 0
      update_board
      @game_manager.game_update(@is_game_over)
    end
  end

end
